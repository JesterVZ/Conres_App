import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';
/* 
list-element.dart
Элемент в списке

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class ListElement extends StatelessWidget {
  String text;
  String id;
  Function remove;
  ListElement({required this.text, required this.id, required this.remove});
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
            onTap: () => remove.call(id),
            child: SvgPicture.asset("assets/list-close.svg"),
          )
        ],
      ),
    );
  }
}
