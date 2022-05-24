import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileElement extends StatelessWidget {
  String? filename;
  FileElement({this.filename});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ]),
      child: Row(
      children: [
        Text(filename ??= "", style: TextStyle(fontSize: 20)),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(left: 8),
            child: SvgPicture.asset('assets/remove-file.svg')
            )
        )
      ],
    ),
    );
  }
}
