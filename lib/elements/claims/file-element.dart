import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../consts.dart';
/* 
file-element.dart
Виджет для загрузки файлов (используется в заявлениях)

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class DocElement extends StatefulWidget {
  int id;
  Function(int, FilePickerResult) result;
  DocElement({required this.id, required this.result});
  @override
  State<StatefulWidget> createState() => _DocElement();
}

class _DocElement extends State<DocElement> {
  FilePickerResult? file;
  void pick() async {
    file = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (file != null) {
      setState(() {
        widget.result.call(widget.id, file!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pick();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 18, right: 18),
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: borderProfileColor)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: colorGray),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/file-icon.svg",
                      color: Colors.white)),
            ),
            Flexible(
                child: Text(file != null ? file!.files[0].name : "Выбрать файл",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colorGrayClaim))),
            const Spacer(),
            Visibility(
                visible: false,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset('assets/remove-file.svg'),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
