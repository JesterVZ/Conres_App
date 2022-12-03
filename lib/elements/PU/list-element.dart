import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';

class ListElement extends StatelessWidget {
  String text;
  ListElement({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6, bottom: 6),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: messageColor)),
      child: Row(
        children: [
          Text(text),
          const Spacer(),
          GestureDetector(
            child: SvgPicture.asset("assets/list-close.svg"),
          )
        ],
      ),
    );
  }
}
