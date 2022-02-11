import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class CustomDropdown extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CustomDropdown();
}

class _CustomDropdown extends State<CustomDropdown>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(
            color: colorGray
          )

        ),
      ),
    )
  }

}