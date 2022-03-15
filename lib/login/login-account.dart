import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/alert.dart';
import '../elements/bloc-screen.dart';
import '../elements/header.dart';
import '../network.dart';
import '../profile/main-page.dart';
import '../profile/profile-ls.dart';
import '../shared-preferences/shared-preferences.dart';

class LoginEmail extends StatefulWidget {
  LoginEmail({Key? key, required this.type}) : super(key: key);
  bool isLoading = false;
  final int type;

  @override
  State<StatefulWidget> createState() => _LoginEmail();
}

class _LoginEmail extends State<LoginEmail> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthBloc? authBloc;

  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Padding(
                    padding: EdgeInsets.fromLTRB(21, 74, 21, 0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 14),
                          child: HeaderRow(loginAccount, 34, false),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lkInputText,
                                  style: labelTextStyle,
                                ),
                                TextField(
                                  controller: lkController,
                                  decoration: InputDecoration(
                                      hintText: "Лицевой счет",
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: inputBorder))),
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(bottom: 26),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lkPasswordText,
                                  style: labelTextStyle,
                                ),
                                TextField(
                                  controller: passwordController,
                                  autofocus: false,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Пароль",
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: inputBorder))),
                                )
                              ],
                            )),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55.0,
                                  child: ElevatedButton(
                                      onPressed: () {

                                        _handleLogin(state, lkController.text,
                                            passwordController.text);
                                      },
                                      child: Text(
                                        login,
                                        style: buttonTextStyle,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: colorMain))),
                            ),

                            //ElevatedButton(onPressed: (){}, child: Text(login)),
                          ],
                        ),
                        Visibility(
                            visible: widget.isLoading,
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/loading.gif'),
                            ))
                      ],
                    ))),
          );
        });
  }

  _handleLogin(AuthState state, String username, String password) async {
    authBloc!.login(username, password, widget.type);
  }

  _listener(BuildContext context, AuthState state) {
    if (state.loading!) {
      widget.isLoading = true;
      return;
    } else {
      widget.isLoading = false;
    }
    if (state.error == null) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => MainPage(profile: state.profile)), (route) => false);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Ошибка", text: state.error.toString()));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
  }
}
