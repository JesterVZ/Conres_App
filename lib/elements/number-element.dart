import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';

class NumberElement extends StatelessWidget{
  final String number;

  NumberElement(this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      decoration: BoxDecoration(
          color: profileColor,
          border: Border.all(color: borderProfileColor),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
          padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ls,
                      style: TextStyle(
                          color: profileLabelColor,
                          fontSize: 15)),
                  Text(number,
                      style: const TextStyle(
                          color: Colors.black, fontSize: 18))
                ],
              ),
              const Spacer(),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: lsButtonColor,
                    shape: BoxShape.circle
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(13, 9, 11, 9),
                  child: SvgPicture.asset("assets/ls-right-arrow.svg", color: colorMain,),
                ),
              )
            ],
          )),
    );
  }
}