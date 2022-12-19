import 'package:conres_app/Services/update-ticket-service.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/chats/new-chat.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/elements/not-found.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../DI/dependency-provider.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/chat/ticket-row.dart';
import '../enums/chat-types.dart';
import '../model/ticket.dart';
import '../websocket/websocket-listener.dart';
import 'messages.dart';

class Chats extends StatefulWidget {
  Function? mainListener; //ссылка на основной listener для сокета
  Chats({Key? key, required this.mainListener}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Chats();
}

class _Chats extends State<Chats> {
  ProfileBloc? profileBloc;
  WebSocketChannel? webSocketChannel;
  WebSocketListener? webSocketListener;
  ScrollController scrollController = ScrollController();
  UpdateTicketService? updateTicketService;
  List<Ticket> tickets = [];
  Map<String, dynamic> ticketsMap = {};

  String? userId;
  int page = 1;
  bool isLoaded = false;
  bool isLoading = true;

  @override
  void initState() {
    scrollController.addListener(_pagination);
    super.initState();
  }

  void refrashDelegate() {
    isLoaded = false;
    tickets.clear();
    profileBloc!.getTickets(page.toString());
  }

  Future<void> _refrash() async {
    isLoaded = false;
    tickets.clear();
    profileBloc!.getTickets(page.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
              header: HeaderNotification(text: "Обращения"),
              body: Stack(
                children: [
                  ListView.builder(
                      itemCount: ticketsMap.length,
                      itemBuilder: (context, int index) {
                        return TicketRow(
                            ticket: ticketsMap.values.elementAt(index),
                            openChat: _openChat,
                            counter: ticketsMap.values
                                .elementAt(index)
                                .count_tm_resiver);
                      }),
                  Visibility(
                    visible:
                        ticketsMap.isEmpty && isLoading == false ? true : false,
                    child: NotFound(
                        title: "Обращения",
                        text:
                            "У вас возникли вопросы или появилась проблема?Создайте обращение и мы ответим вам в ближайщее время."),
                  ),
                  Visibility(
                      child: Center(
                          child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(color: colorMain),
                      )),
                      visible: (isLoading == true) ? true : false)
                ],
              ),
              footer: DefaultButton(
                isGetPadding: true,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewChat(refrash: refrashDelegate)));
                },
                text: "Новое обращение",
              ),
              onRefrash: _refrash);
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    } else {
      isLoading = false;
    }
    if (state.fullInfo != null) {
      userId = state.fullInfo!['user_id'];
    }
    if (state.tickets != null && state.tickets!.isNotEmpty) {
      ticketsMap = {for (var e in state.tickets!) e.ticket_id!: e};

      if (tickets.isEmpty ||
          (tickets.first.ticket_id != state.tickets!.first.ticket_id &&
              (int.parse(state.page!) == page) &&
              page == 1)) {
        tickets = state.tickets!;
        ticketsMap = {for (var e in state.tickets!) e.ticket_id!: e};
      }

      if ((int.parse(state.page!) == page) && page > 1) {
        tickets = tickets + state.tickets!;
        ticketsMap = {for (var e in tickets) e.ticket_id!: e};
      }
    }
  }

  void _pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        page++;
        profileBloc!.getTickets(page.toString());
      });
    }
  }

  void updateStatus(String ticket_id, String status) {
    Ticket newTicket = ticketsMap[ticket_id];
    newTicket.cur_status!.name = status;
    setState(() {
      ticketsMap.update(ticket_id, (value) => newTicket);
    });
    refrashDelegate();
  }

  void _openChat(Ticket ticket) {
    ticket.count_tm_resiver = "0";
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessagesPage(
                mainListener: widget.mainListener,
                genericId: ticket.ticket_id.toString(),
                type: ChatTypes.Ticket,
                page: '1',
                statusName:
                    ticket.cur_status != null ? ticket.cur_status!.name : "")));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    updateTicketService ??= DependencyProvider.of(context)!.updateTicketService;
    updateTicketService!.update = updateStatus;
    profileBloc!.getAllInfo();
    profileBloc!.getTickets(page.toString());
  }
}
