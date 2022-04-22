import 'package:conres_app/login/login-main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../profile/main-page.dart';

class LoadingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage>{
  AuthBloc? authBloc;
  var mainPage = LoadingPage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
              body:  Stack(
                fit: StackFit.expand,
              )
          );
        });
  }
  _listener(BuildContext context, AuthState state) {
    if(state.loading == true){
      return;
    }
    if(state.loginData != null){
      if(state.profile == null){
        authBloc!.login(state.loginData![0], state.loginData![1], state.loginData![2]);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => MainPage(profile: state.profile)), (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (route) => false);
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    authBloc!.getLogin();
  }
}