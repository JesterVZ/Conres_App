import 'package:conres_app/registration/registration-fl.dart';
import 'package:conres_app/registration/registration-ip.dart';
import 'package:conres_app/registration/registration-ul.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';
import '../elements/header/header.dart';
import 'login-account.dart';

class ChangeType extends StatefulWidget {
  const ChangeType({Key? key, required this.isReg}) : super(key: key);
  final bool isReg;

  @override
  State<StatefulWidget> createState() => _ChangeType();
}

class _ChangeType extends State<ChangeType> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                width: 375,
                left: 26,
                top: 85,
                child: HeaderRow(text: lkChooseType, fontSize: 34)),
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
                              widget.isReg ? Navigator.push(context, MaterialPageRoute(builder:  (context) => RegUL())) : Navigator.push(context, MaterialPageRoute(builder:  (context) => LoginEmail(type: 3)));
                            },
                            child: Text(
                              ul,
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: colorMain,
                            shape: RoundedRectangleBorder(
                              borderRadius: buttonRadius
                            )))),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 55.0,
                        child: ElevatedButton(
                            onPressed: () {
                              widget.isReg ? Navigator.push(context, MaterialPageRoute(builder:  (context) => RegFL())) : Navigator.push(context, MaterialPageRoute(builder:  (context) => LoginEmail(type: 1)));
                            },
                            child: Text(
                              fl,
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: buttonRadius
                            )))),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 55.0,
                        child: ElevatedButton(
                            onPressed: () {
                              widget.isReg ? Navigator.push(context, MaterialPageRoute(builder:  (context) => RegIP())) : Navigator.push(context, MaterialPageRoute(builder:  (context) => LoginEmail(type: 2)));
                            },
                            child: Text(
                              ip,
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: buttonRadius
                            )))),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
