import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import 'new-claim/new-claim-step-1.dart';

class Claims extends StatefulWidget {
  const Claims({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Claims();
}

class _Claims extends State<Claims> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(21, 74, 21, 0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 55,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder:  (context) => NewClaimStep1()));
                              },
                              child:
                              Text(
                                "Заявление на тех.присоединение",
                                style: buttonTextStyle,
                              ),
                              style: ElevatedButton.styleFrom(primary: colorMain))
                      )
                    ],
                  ))
    ])));
  }
}
