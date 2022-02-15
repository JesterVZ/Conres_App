import 'package:conres_app/login/change-type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../elements/header.dart';
import '../login/login-account.dart';
import '../profile/main-page.dart';
import '../profile/profile-ls.dart';
import '../profile/profile-no-ls.dart';

class RegSuccess extends StatefulWidget {
  const RegSuccess({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegSuccess();
}

class _RegSuccess extends State<RegSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(21, 74, 21, 0),
                child: Column(
                  children: [
                    HeaderRow(successRed, 33, false),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: Column(
                          children: [
                            const Image(image: AssetImage('assets/success.png')),
                            Text(sendLogin,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20))
                          ],
                        ))
                  ],
                ),)

              ],
            ),),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(27, 0, 27, 51),
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:  (context) => const MainPage()));
                },
                child:
                Text(
                  next,
                  style: buttonTextStyle,
                ),
                style: ElevatedButton.styleFrom(primary: colorMain))
          ),
        )
        );
  }
}
