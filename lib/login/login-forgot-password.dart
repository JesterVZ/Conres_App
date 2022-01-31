import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';
import 'login-step-1.dart';

class LoginForgotPassword extends StatefulWidget {
  const LoginForgotPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginForgotPassword();
}

class _LoginForgotPassword extends State<LoginForgotPassword> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                width: 375,
                left: 26,
                top: 26,
                child: Text(forgotPassword,
                    style: const TextStyle(
                        fontFamily: 'Bubicon-Bold', fontSize: 36.0))),
            Positioned(
              width: 325,
              left: 26,
              top: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inn,
                    style: TextStyle(color: colorGrayText, fontSize: 16.0),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: inputBorder))),
                  )
                ],
              ),
            ),
            Positioned(
              width: 325,
              left: 26,
              top: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    email,
                    style: TextStyle(color: colorGrayText, fontSize: 16.0),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: inputBorder))),
                  )
                ],
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: 320,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 55.0,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              clearPassword,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            style:
                            ElevatedButton.styleFrom(primary: colorMain))),
                  ),

                  //ElevatedButton(onPressed: (){}, child: Text(login)),
                ],
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 20,
              child: Column(
                children: [
                  /*
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 55.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ChangeType()));
                          },
                          child: Text(
                            back,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          style: ElevatedButton.styleFrom(primary: colorGray))),
*/
                  //ElevatedButton(onPressed: (){}, child: Text(login)),
                ],
              ),
            )
          ],
        ));
  }
}
