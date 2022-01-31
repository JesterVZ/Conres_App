import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';
import 'login-step-2.dart';

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
        appBar: AppBar(),
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(right: 0, child: svg),
            Positioned(
                width: 375,
                left: 26,
                top: 26,
                child: Text(lkChooseType,
                    style: const TextStyle(
                        fontFamily: 'Bubicon-Bold', fontSize: 36.0))),
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
                              Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginEmail()));
                            },
                            child: Text(
                              ul,
                              style: const TextStyle(fontSize: 18.0),
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
                              Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginEmail()));
                            },
                            child: Text(
                              fl,
                              style: const TextStyle(fontSize: 18.0),
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
                              Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginEmail()));
                            },
                            child: Text(
                              ip,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(primary: colorMain))),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 55.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            back,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          style: ElevatedButton.styleFrom(primary: colorGray))),

                  //ElevatedButton(onPressed: (){}, child: Text(login)),
                ],
              ),
            )
          ],
        ));
  }
}
