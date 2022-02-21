import 'package:conres_app/model/profile.dart';
import 'package:conres_app/registration/registration-fl.dart';
import 'package:conres_app/registration/seccessful-registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc-screen.dart';
import 'login-account.dart';
import 'change-type.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');
  AuthBloc? authBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(right: 0, child: svg),
            Padding(
                padding: EdgeInsets.only(left: 27, right: 27, top: 76),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Text(lkTitle,
                            style: const TextStyle(
                                fontFamily: 'Bubicon-Bold',
                                fontSize: 36.0)))
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
                                      const ChangeType()));
                            },
                            child: Text(
                              reg,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: colorMain))),
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
                                    const LoginEmail()));
                          },
                          child: Text(
                            login,
                            style: buttonTextStyle,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: colorGray))),

                  //ElevatedButton(onPressed: (){}, child: Text(login)),
                ],
              ),
            )
          ],
        ));


  }

}
