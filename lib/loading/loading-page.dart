import 'package:conres_app/login/login-main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../profile/main-page.dart';
import '../profile/profile-ls.dart';

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
                children: [

                ],
              )
          );
        });
  }
  _listener(BuildContext context, AuthState state) {
    //print(state.toString());
    if(state.loading == true){
      return;
    }
    if(state.loginData != null){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => MainPage(loginData: state.loginData)), (route) => false);
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