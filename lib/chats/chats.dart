import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/bloc-screen.dart';
import '../elements/chat/ticket-element.dart';
import '../elements/dropdown.dart';

class Chats extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Chats();
}

class _Chats extends State<Chats>{
  AuthBloc? authBloc;
  late WebSocketChannel? webSocketChannel;

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
    builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                TicketElement(1, "test"),
                TicketElement(1, "test"),
                TicketElement(1, "test"),
                TicketElement(1, "test"),
                TicketElement(1, "test"),
              ],
            )

          );
    });
  }

  _listener(BuildContext context, AuthState state) {

  }

  void _connectToSocket() async{
    webSocketChannel = IOWebSocketChannel.connect("wss://promo.dev.conres.ru:2450/");
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
  }
}