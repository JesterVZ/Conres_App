import 'package:conres_app/login/login-step-1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class RegSuccess extends StatefulWidget{
  const RegSuccess({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegSuccess();

}
class _RegSuccess extends State<RegSuccess>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              width: 375,
              left: 26,
              top: 26,
              child: Text(successRed,
                  style: const TextStyle(
                      fontFamily: 'Bubicon-Bold', fontSize: 36.0))),
          Positioned(top: 140, child: Column(
            children: [
              const Image(image: AssetImage('assets/success.png')),
              Container(
                width: 314,
                child: Text(sendLogin, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontFamily: 'Bubicon-Medium', ),)
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
                            Navigator.push(context, MaterialPageRoute(builder:  (context) => const RegSuccess()));
                          },
                          child: Text(
                            next,
                            style: const TextStyle(fontSize: 18.0),
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