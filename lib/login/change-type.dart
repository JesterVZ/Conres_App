import 'package:conres_app/registration/registration-fl.dart';
import 'package:conres_app/registration/registration-ip.dart';
import 'package:conres_app/registration/registration-ul.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DI/dependency-provider.dart';
import '../Services/profile-service.dart';
import '../UI/default-button.dart';
import '../consts.dart';
import '../elements/header/header.dart';
import 'login-account.dart';
/* 
change-type.dart
Выбор типа (второй шаг)

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class ChangeType extends StatefulWidget {
  const ChangeType({Key? key, required this.isReg}) : super(key: key);
  final bool isReg;

  @override
  State<StatefulWidget> createState() => _ChangeType();
}

class _ChangeType extends State<ChangeType> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ProfileService? profileService;
  SharedPreferences? preferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                width: MediaQuery.of(context).size.width,
                left: defaultSidePadding,
                top: 74,
                child: HeaderRow(
                    text: widget.isReg == true
                        ? "Выберите тип (Регистрация)"
                        : "Выберите тип (Авторизаця)",
                    fontSize: 34)),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 20,
              child: Column(
                children: [
                  DefaultButton(
                      margin: EdgeInsets.only(bottom: 20),
                      text: fl,
                      isGetPadding: true,
                      onPressed: () {
                        preferences!.setString('lkType', "fl");
                        profileService!.userType = "fl";
                        widget.isReg
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegFL()))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginEmail(type: 1)));
                      }),
                  DefaultButton(
                      margin: EdgeInsets.only(bottom: 20),
                      text: ip,
                      isGetPadding: true,
                      onPressed: () {
                        preferences!.setString('lkType', "ip");
                        profileService!.userType = "ip";
                        widget.isReg
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegIP()))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginEmail(type: 2)));
                      }),
                  DefaultButton(
                      margin: EdgeInsets.only(bottom: 20),
                      text: ul,
                      isGetPadding: true,
                      onPressed: () {
                        preferences!.setString('lkType', "ul");
                        profileService!.userType = "ul";
                        widget.isReg
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegUL()))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginEmail(type: 3)));
                      }),
                ],
              ),
            )
          ],
        ));
  }

  @override
  void didChangeDependencies() async {
    profileService ??= DependencyProvider.of(context)!.profileService;
    preferences = await SharedPreferences.getInstance();
    super.didChangeDependencies();
  }
}
