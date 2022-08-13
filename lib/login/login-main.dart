import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/auth/auth-block.dart';
import '../consts.dart';
import 'change-type.dart';

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
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 55.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangeType(isReg: true)));
                            },
                            child: Text(
                              reg,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: colorMain,
                                shape: RoundedRectangleBorder(
                                    borderRadius: buttonRadius)))),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 55.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangeType(isReg: false)));
                          },
                          child: Text(
                            login,
                            style: buttonTextStyle,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: colorGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: buttonRadius)))),
                  //ElevatedButton(onPressed: (){}, child: Text(login)),
                ],
              ),
            )
          ],
        ));
  }
}
