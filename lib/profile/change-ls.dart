import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/number-element.dart';

class ChangeLs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ChangeLs();
}

class _ChangeLs extends State<ChangeLs>{
  AuthBloc? authBloc;
  List<Widget> numbers = [];
  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
    builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: numbers,
              ),
            ),
          );
    });
  }
  _listener(BuildContext context, AuthState state){
    if(state.loading == true){
      return;
    }
    if(state.numbers!.isNotEmpty){
      for(int i = 0; i < state.numbers!.length; i++){
        numbers.add(NumberElement(state.numbers![i]));
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    authBloc!.getNumbers();
  }
}