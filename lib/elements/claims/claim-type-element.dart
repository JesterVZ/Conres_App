import 'package:conres_app/claims/new-claim/new-claim-step-1.dart';
import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClaimTypeELement extends StatelessWidget{
  String text;
  ClaimTypeELement({
    required this.text
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => NewClaimStep1()))),
      child: Container(
      margin: EdgeInsets.only(bottom: 19),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
        ]
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 9),
            child: Row(
            children: [
              Text("Тип заявления", style: TextStyle(color: colorGray, fontSize: 15)),
              const Spacer(),
              SvgPicture.asset("assets/ls-right-arrow.svg")
            ],
          ),
          ),
          
          Text(text, style: TextStyle(fontSize: 18),)
        ],
      ),
    )
    );
  }
}