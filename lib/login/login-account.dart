import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
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
                        DefaultInput(
                            labelText: lkInputText,
                            hintText: "Лицевой счет",
                            keyboardType: TextInputType.text,
                            controller: lkController),
                        DefaultInput(
                            labelText: lkPasswordText,
                            hintText: "Пароль",
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            controller: passwordController),
                        DefaultButton(
                            text: login,
                            onPressed: () {
                              _handleLogin(
                                  lkController.text, passwordController.text);
                            },
                            isGetPadding: false),
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
        btnOkColor: Colors.red,
        desc: state.error.toString(),
        btnOkOnPress: () {},
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
