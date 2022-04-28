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
import '../model/ticket.dart';
import 'messages.dart';


class Chats extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Chats();
}

class _Chats extends State<Chats>{
  ProfileBloc? profileBloc;
  late WebSocketChannel? webSocketChannel;
  List<Widget> tickets = [];

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
    if(state.tickets != null){
      for(int i= 0; i < state.tickets!.length; i++){
        tickets.add(TicketRow(ticket: state.tickets![i], openChat: _openChat));
      }
    }
    if(state.messages != null){
      Navigator.push(context, MaterialPageRoute(builder:  (context) => MessagesPage(messages: state.messages)));
    }

  }

  void _openChat(Ticket ticket){
    profileBloc!.getMessages(ticket.ticket_id.toString(), "1", "1");
  }

  void _connectToSocket() async{
    webSocketChannel = IOWebSocketChannel.connect("wss://promo.dev.conres.ru:2450/");
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getTickets();
  }
}