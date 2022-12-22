import 'dart:io';

import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
/* 
file-for-send.dart
Превью файла

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class FileElement extends StatelessWidget {
  String? filename;
  String? filepath;
  String? extension;
  VoidCallback func;
  FileElement({this.filename, this.filepath, this.extension, required this.func});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image.file(File(filepath!)),
            ),
          ],
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Container(
                width: 20,
                height: 20,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor: colorGray,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      func.call();
                    },
                    child: SvgPicture.asset('assets/remove-file.svg',
                        color: Colors.white, width: 10, height: 10))))
      ],
    ));
  }
}
