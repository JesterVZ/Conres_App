import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/MeterInfo.dart';
import '../elements/bloc/bloc-screen.dart';
/* 
edit-pu.dart
Информация о ПУ

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class InfoPU extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoPU();
}

class _InfoPU extends State<InfoPU> {
  AuthBloc? authBloc;
  Widget content = Container();
  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(21, 58, 21, 54),
                  child: content,
            )),
          );
          return content;
        });
  }

  _listener(BuildContext context, AuthState state) {
    if (state.loading!) {
      content = Center(
          child: Container(
              width: 50, height: 50, child: Image.asset('assets/loading.gif')));
      return;
    }
    if (state.testimony != null) {
      try {
        List<Widget> meters = [];
        for (int i = 0; i < state.testimony!.length; i++) {
          meters.add(MeterInfo(state.testimony![i]));
        }
        content = Column(
          children: meters,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void didChangeDependencies() {
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    //authBloc!.getTestimony();
    super.didChangeDependencies();
  }
}
