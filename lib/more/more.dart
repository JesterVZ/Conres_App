import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../elements/header/header-notification.dart';
import '../elements/header/header.dart';
import '../profile/full-profile-page.dart';
import '../testimony/info-pu.dart';

class MoreScreen extends StatefulWidget {
  final VoidCallback logout;
  MoreScreen(this.logout);
  @override
  State<StatefulWidget> createState() => _MoreScreen();
}

class _MoreScreen extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                child: Column(
                  children: [
                    Container(
                  margin: EdgeInsets.only(top: 52),
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding, bottom: 12),
                    child: HeaderNotification(
                      text: "Ещё",
                    )),
                    Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              
                            ],
                          ),
                        )
                                        ),
                    Container(
                      padding: EdgeInsets.only(
                          left: defaultSidePadding, right: defaultSidePadding),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        child: Text("Новое обращение", style: buttonTextStyle),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    )
                  ],
                ),
              )
    );
  }
}
