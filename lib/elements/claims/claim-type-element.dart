import 'package:conres_app/claims/new-claim/new-claim-step-1.dart';
import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
/* 
claim-type-element.dart
Виджет типа заявлений (используется в new-claim-document)

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class ClaimTypeELement extends StatelessWidget {
  String text;
  VoidCallback func;
  ClaimTypeELement({required this.text, required this.func});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => func.call(),
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: EdgeInsets.all(18),
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
                margin: EdgeInsets.only(bottom: 9),
                child: Row(
                  children: [
                    Text("Тип заявления",
                        style: TextStyle(color: colorGray, fontSize: 15)),
                    const Spacer(),
                    SvgPicture.asset("assets/ls-right-arrow.svg")
                  ],
                ),
              ),
              Text(
                text,
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ));
  }
}
