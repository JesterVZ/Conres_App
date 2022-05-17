import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../DI/dependency-provider.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/chat/ticket-row.dart';
import '../model/profile.dart';
import '../model/ticket.dart';
import '../websocket/websocket-listener.dart';
import 'messages.dart';

class Chats extends StatefulWidget {
  Profile profile;
  Chats({Key? key, required this.profile}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Chats();
}

class _Chats extends State<Chats> {
  ProfileBloc? profileBloc;
  WebSocketChannel? webSocketChannel;
  WebSocketListener? webSocketListener;
  //List<Widget> tickets = [];
  List<Ticket> tickets = [];
  String? userId;
  bool? isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
              body: Container(
            padding: const EdgeInsets.only(left: 18, right: 18),
            color: pageColor,
            child: Column(
              children: [
                Container(
                    height: 100, child: HeaderNotification(text: reportsPage)),
                Expanded(
                    child: Scrollbar(
                        child: ListView.builder(itemCount: tickets.length, itemBuilder: (context, int index){
                          return TicketRow(ticket: tickets[index], openChat: _openChat, counter: tickets[index].count_tm_resiver);
                        }))),
              ],
            ),
          ));
        });
  }

  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading;
    if (state.loading == true) {
      return;
    }
    if (state.bindLsData != null) {
      userId = state.bindLsData!.data['user_id'];
    }
    if (state.tickets != null) {
      //tickets.clear();
      if(tickets.isEmpty){
        tickets = state.tickets!;
        /*
        for (int i = 0; i < state.tickets!.length; i++) {
          tickets.add(TicketRow(ticket: state.tickets![i], openChat: _openChat, counter: state.tickets![i].count_tm_resiver));
        }
        */
      }
    }
  }

  void _openChat(Ticket ticket) {
    ticket.count_tm_resiver = "0";
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessagesPage(
                userId: userId!,
                ticketId: ticket.ticket_id.toString(),
                page: '1',
                profile: widget.profile,
                statusName: ticket.cur_status!.name)));
  }

  void getData(dynamic event) async{
    if(isLoading == false){
      //profileBloc!.getTickets();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getAllInfo();
    profileBloc!.getTickets();
  }
}
