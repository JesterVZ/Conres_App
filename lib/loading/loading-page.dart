import 'package:conres_app/login/login-main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../Services/profile-service.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../profile/main-page.dart';

class LoadingPage extends StatefulWidget {
  String? newLogin;
  LoadingPage({this.newLogin});
  @override
  State<StatefulWidget> createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  AuthBloc? authBloc;
  WebSocketChannel? webSocketChannel;
  SharedPreferences? sharedPreferences;
  ProfileService? profileService;
  var mainPage = LoadingPage();
  bool isLogin = false;

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
              body: Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      child: const CircularProgressIndicator())));
        });
  }

  _listener(BuildContext context, AuthState state) {
    if (state.loading == true) {
      return;
    }
    if (state.loginData != null) {
      profileService!.userType =
          sharedPreferences!.getString("lkType"); //получить тип ЛК
      if (isLogin == false) {
        if (widget.newLogin != null) {
          authBloc!.login(
              widget.newLogin!, state.loginData![1], state.loginData![2]);
          isLogin = true;
        } else {
          authBloc!.login(
              state.loginData![0], state.loginData![1], state.loginData![2]);
          isLogin = true;
        }
      }
      if (state.cookies != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()),
          (route) => false);
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel(false);
    profileService ??= DependencyProvider.of(context)!.profileService;
    sharedPreferences = await SharedPreferences.getInstance();
    authBloc!.getLogin();
  }
}
