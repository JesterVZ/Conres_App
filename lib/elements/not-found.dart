import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
/* 
not-found.dart
Покажывается, если не найдено что-либо

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
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
                  boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFFD4D9E6),
                                        spreadRadius: 5,
                                        blurRadius: 16,
                                        offset: Offset(0, 8),
                                      )]),
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