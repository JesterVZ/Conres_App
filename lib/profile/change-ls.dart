import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/number-element.dart';

class ChangeLs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ChangeLs();
}

class _ChangeLs extends State<ChangeLs>{
  ProfileBloc? profileBloc;
  List<Widget> numbers = [];
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
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
  _listener(BuildContext context, ProfileState state){
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
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getNumbers();
  }
}