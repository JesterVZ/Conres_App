import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
  }
}