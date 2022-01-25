import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('assets/logo.jpg')),
                    Container(
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Roboto',
                                color: colorMain)),
                        margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0))
                  ],
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 1.2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3),)]),
                  child: Container(padding: const EdgeInsets.all(16.0),
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        lkTitle,
                        style: const TextStyle(
                            fontSize: 15.2, fontFamily: 'Roboto'),
                      ),

                    ],
                  ),)

                ),
              )
            ],
          ),
        ));
  }
}
