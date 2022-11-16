import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/alert.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header.dart';
import '../elements/route/def-page-router.dart';
import '../profile/main-page.dart';

class LoginEmail extends StatefulWidget {
  LoginEmail({Key? key, required this.type}) : super(key: key);
  final int type;

  @override
  State<StatefulWidget> createState() => _LoginEmail();
}

class _LoginEmail extends State<LoginEmail> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthBloc? authBloc;
  ProfileBloc? profileBloc;
  bool? isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: Padding(
                    padding: EdgeInsets.fromLTRB(
                        defaultSidePadding, 70, defaultSidePadding, 0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 14),
                          child: HeaderRow(text: loginAccount, fontSize: 34),
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
                                            BorderSide(color: inputBorder),
                                        borderRadius: buttonRadius),
                                  ),
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
                                            BorderSide(color: inputBorder),
                                        borderRadius: buttonRadius,
                                      )),
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
                                        _handleLogin(lkController.text,
                                            passwordController.text);
                                      },
                                      child: Text(
                                        login,
                                        style: buttonTextStyle,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: colorMain,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: buttonRadius)))),
                            ),

                            //ElevatedButton(onPressed: (){}, child: Text(login)),
                          ],
                        ),
                        Visibility(
                            visible: isLoading!,
                            child: Container(
                                width: 50,
                                height: 50,
                                child: const CircularProgressIndicator()))
                      ],
                    ))),
          );
        });
  }

  _handleLogin(String username, String password) async {
    authBloc!.login(username, password, widget.type);
  }

  _listener(BuildContext context, AuthState state) {
    isLoading = state.loading!;
    if (state.error != null) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Ошибка!",
        desc: state.error.toString(),
        btnOkOnPress: () {
        },
        ).show();
    }
    if (state.cookies != null) {
      Navigator.of(context)
          .pushAndRemoveUntil(DefaultPageRouter(MainPage()), (route) => false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
  }
}
