import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              right: 0,
                child: svg),
            Positioned(
              width: 375,
              left: 26,
                top: 26,
                child: Text(lkTitle, style: const TextStyle(fontFamily: 'Bubicon-Bold', fontSize: 36.0))
            ),

            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 20,
              child: Column(
                children: [
                  ElevatedButton(onPressed: (){}, child: Text(reg)),
                  ElevatedButton(onPressed: (){}, child: Text(login)),
                ],
              ),
            )

          ],
        ));
  }
}
