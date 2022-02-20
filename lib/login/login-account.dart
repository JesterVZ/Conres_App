import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';
import '../elements/header.dart';
import '../network.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginEmail();
}

class _LoginEmail extends State<LoginEmail> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.fromLTRB(21, 74, 21, 0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 14),
                child: HeaderRow(loginAccount, 34, false),
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
                        decoration: InputDecoration(
                            hintText: "E-mail",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: inputBorder))),
                      )
                    ],
                  )
              ),
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
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(

                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: inputBorder))),
                      )
                    ],
                  )
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 55.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Future<Object> testdata = loginfunc("123456789000", "123456");
                            },
                            child: Text(
                              login,
                              style: buttonTextStyle,
                            ),
                            style:
                            ElevatedButton.styleFrom(primary: colorMain))),
                  ),

                  //ElevatedButton(onPressed: (){}, child: Text(login)),
                ],
              )


            ],
          )
        )
       );
  }
}
