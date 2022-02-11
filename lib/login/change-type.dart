import 'package:conres_app/registration/registration-fl.dart';
import 'package:conres_app/registration/registration-ip.dart';
import 'package:conres_app/registration/registration-ul.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';
import '../elements/header.dart';
import 'login-account.dart';

class ChangeType extends StatefulWidget {
  const ChangeType({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangeType();
}

class _ChangeType extends State<ChangeType> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(right: 0, child: svg),
            Positioned(
                width: 375,
                left: 26,
                top: 26,
                child: HeaderRow(lkChooseType, 34, false)),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 20,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 55.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:  (context) => const RegUL()));
                            },
                            child: Text(
                              ul,
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(primary: colorMain))),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 55.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:  (context) => const RegFL()));
                            },
                            child: Text(
                              fl,
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(primary: colorMain))),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 55.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:  (context) => const RegIP()));
                            },
                            child: Text(
                              ip,
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(primary: colorMain))),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
