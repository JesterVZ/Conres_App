import 'package:conres_app/login/login-step-1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../elements/header.dart';
import '../profile/main-page.dart';
import '../profile/profile-ls.dart';
import '../profile/profile-no-ls.dart';

class RegSuccess extends StatefulWidget{
  const RegSuccess({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegSuccess();

}
class _RegSuccess extends State<RegSuccess>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              width: 375,
              left: 26,
              top: 26,
              child: Container(width: 326, child: HeaderRow(successRed, 34))),
          Positioned(top: 140, child: Column(
            children: [
              const Image(image: AssetImage('assets/success.png')),
              Container(
                width: 314,
                child: Text(sendLogin, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20 ),)
              ),

            ],
          )),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 20,
            child: Column(
              children: [
                Container(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 55.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:  (context) => const MainPage()));
                          },
                          child: Text(
                            next,
                            style: buttonTextStyle,
                          ),
                          style: ElevatedButton.styleFrom(primary: colorMain))),
                ),

                //ElevatedButton(onPressed: (){}, child: Text(login)),
              ],
            ),
          )

        ],
      ) ,
    );
  }

}