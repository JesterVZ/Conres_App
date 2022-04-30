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
import 'messages.dart';


class Chats extends StatefulWidget{
  Profile profile;
  Chats({Key? key, required this.profile}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Chats();
}

class _Chats extends State<Chats>{
  ProfileBloc? profileBloc;
  late WebSocketChannel? webSocketChannel;
  List<Widget> tickets = [];
  String? userId;

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
                        height: 100,
                        child: HeaderNotification(text: reportsPage)
                    ),
                    Expanded(child: Scrollbar(child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                                children: tickets
                            )
                          ],
                        )
                    ))),
                  ],
                ),
              )
          );
    });
  }

  _listener(BuildContext context, ProfileState state) {
    if(state.loading == true){
      return;
    }
    if(state.bindLsData != null){
      userId = state.bindLsData!.data['user_id'];
    }
    if(state.tickets != null){
      tickets.clear();
      for(int i= 0; i < state.tickets!.length; i++){
        tickets.add(TicketRow(ticket: state.tickets![i], openChat: _openChat));
      }
    }

  }

  void _openChat(Ticket ticket){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder:  (context) => MessagesPage(userId: userId!, ticketId: ticket.ticket_id.toString(), page: '1', lastMessageId: '1')));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getAllInfo();
    profileBloc!.getTickets();
  }
}