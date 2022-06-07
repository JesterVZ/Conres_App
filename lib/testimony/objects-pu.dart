import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/bloc/bloc-screen.dart';

class ObjectsPU extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ObjectsPU();
}

class _ObjectsPU extends State<ObjectsPU>{
  ProfileBloc? profileBloc;
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                
              )
            ],
          ),
        );
      }
    );
}
_listener(BuildContext context, ProfileState state){

}
  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    super.didChangeDependencies();
  }
}