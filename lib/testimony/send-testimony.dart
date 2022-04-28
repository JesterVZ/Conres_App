import 'dart:core';

import 'package:conres_app/testimony/link-pu.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header-notification.dart';
import '../elements/testimony/testimony.dart';

class SendTestimony extends StatefulWidget {
  final String? personal;

  const SendTestimony({required this.personal});

  @override
  State<StatefulWidget> createState() => _SendTestimony();
}

class _SendTestimony extends State<SendTestimony> {
  AuthBloc? authBloc;
  Widget content = Container(
      margin: EdgeInsets.only(top: 21),
      decoration: DottedDecoration(
        shape: Shape.box,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(testimonyNotFound,
            textAlign: TextAlign.center,
            style: TextStyle(color: dashedColor, fontSize: 16)),
      ));
  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
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
                    child: HeaderNotification(text: "Передача показаний")
                ),
                Expanded(child: Scrollbar(child: SingleChildScrollView(
                    child: content
                ))),
              ],
            ),
          ));
    });

  }
  _listener(BuildContext context, AuthState state){
    if(state.loading!){
      content = Center(
        child: Container(
          width: 50,
          height: 50,
          child: Image.asset('assets/loading.gif')
        )

      );
      return;
    }
    if(state.testimony != null){
      try{
        List<Widget> meters = [];
        for(int i = 0; i < state.testimony!.length; i++){
          meters.add(Testimony(state.testimony![i]));
        }
        content = Column(
          children: meters,
        );

      } catch(e){
        print(e.toString());
      }
    }
  }
  @override
  void didChangeDependencies() {
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    authBloc!.getTestimony();
    super.didChangeDependencies();
  }
}
