import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/chats/new-chat.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../DI/dependency-provider.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/chat/ticket-row.dart';
import '../enums/chat-types.dart';
import '../model/profile.dart';
import '../model/ticket.dart';
import '../websocket/websocket-listener.dart';
import 'messages.dart';

class Chats extends StatefulWidget {
  Profile profile;
  Function? mainListener; //ссылка на основной listener для сокета
  Chats({Key? key, required this.profile, required this.mainListener}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Chats();
}

class _Chats extends State<Chats> {
  ProfileBloc? profileBloc;
  WebSocketChannel? webSocketChannel;
  WebSocketListener? webSocketListener;
  ScrollController scrollController = ScrollController();
  List<Ticket> tickets = [];
  String? userId;
  int page = 1;
  bool isLoading = true;
  @override
  void initState() {
    scrollController.addListener(_pagination);
    super.initState();
  }

  Future<void> _refrash() async {
    tickets.clear();
    profileBloc!.getTickets(page.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                  margin: EdgeInsets.only(top: 52),
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding, bottom: 12),
                    child: HeaderNotification(
                      text: "Обращения",
                    )),
                    Expanded(
                        child: Scrollbar(
                            child: RefreshIndicator(
                                onRefresh: _refrash,
                                child: ListView.builder(
                                        controller: scrollController,
                                        itemCount: tickets.length,
                                        itemBuilder: (context, int index) {
                                          return TicketRow(
                                              ticket: tickets[index],
                                              openChat: _openChat,
                                              counter: tickets[index]
                                                  .count_tm_resiver);
                                        })))),
                    Container(
                      padding: EdgeInsets.only(
                          left: defaultSidePadding, right: defaultSidePadding),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewChat()));
                        },
                        child: Text("Новое обращение", style: buttonTextStyle),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                  child: Center(
                      child: Container(
                    width: 50,
                    height: 50,
                    child: const CircularProgressIndicator(),
                  )),
                  visible: isLoading)
            ],
          ));
        });
  }

  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading!;
    if (state.loading == true) {
      return;
    }
    if (state.bindLsData != null) {
      userId = state.bindLsData!.data['user_id'];
    }
    if (state.tickets != null) {
      //tickets.clear();
      if (tickets.isEmpty ||
          (tickets.first.ticket_id != state.tickets!.first.ticket_id &&
              (int.parse(state.page!) == page) &&
              page == 1)) {
        tickets = state.tickets!;
      }
      if ((int.parse(state.page!) == page) && page > 1) {
        tickets = tickets + state.tickets!;
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

  void _openChat(Ticket ticket) {
    ticket.count_tm_resiver = "0";
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessagesPage(
              mainListener: widget.mainListener,
                userId: userId!,
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
    profileBloc!.getAllInfo();
    profileBloc!.getTickets(page.toString());
  }
}
