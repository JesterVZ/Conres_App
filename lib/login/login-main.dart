import 'package:conres_app/UI/default-button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/auth/auth-block.dart';
import '../consts.dart';
import 'change-type.dart';
/* 
login-main.dart
Страница логина (первый шаг)

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthBloc? authBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 27, right: 27, top: 74),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Text(lkTitle,
                            style: const TextStyle(
                                fontFamily: 'Bubicon-Bold', fontSize: 36.0)))
                  ],
                )),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 20,
              child: Column(
                children: [
                  DefaultButton(
                      margin: EdgeInsets.only(bottom: 20),
                      text: reg,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChangeType(isReg: true)));
                      },
                      isGetPadding: true),
                  DefaultButton(
                      text: login,
                      backgroundColor: colorGray,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChangeType(isReg: false)));
                      },
                      isGetPadding: true),
                ],
              ),
            )
          ],
        ));
  }
}
