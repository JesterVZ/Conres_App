import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

import '../../consts.dart';
import 'file-element.dart';

class ClaimStep7Object extends StatefulWidget {
  int id;
  Function(int, FilePickerResult) pickDocument;
  ClaimStep7Object({Key? key, required this.id, required this.pickDocument})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ClaimStep7Object();
}

class _ClaimStep7Object extends State<ClaimStep7Object> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 15),
          width: MediaQuery.of(context).size.width,
          height: 6,
          decoration: BoxDecoration(
              color: colorMain, borderRadius: BorderRadius.circular(8)),
        ),
        Container(
          margin: EdgeInsets.only(top: 13),
          width: MediaQuery.of(context).size.width,
          child: Text("Дополнительный документ",
              textAlign: TextAlign.left,
              style: TextStyle(color: colorGray, fontSize: 16.0)),
        ),
        DocElement(id: widget.id, result: widget.pickDocument),
      ],
    );
  }
}
