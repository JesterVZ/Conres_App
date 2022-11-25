import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class NotFound extends StatelessWidget{
  String title;
  String text;

  NotFound({required this.title, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.only(
                left: defaultSidePadding, right: defaultSidePadding),
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              height: 175,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 18),
                    child: Row(
                    children: [
                       Text(title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                       Spacer(),
                      Image.asset("assets/search.png")
                    ],
                  ),
                  ),
                  
                  Text(
                    text,
                    style: TextStyle(color: colorGrayClaim, fontSize: 16),
                  )
                ],
              ),
            ));
  }
}