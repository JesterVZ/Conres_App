import 'dart:io';

import 'package:conres_app/consts.dart';
import 'package:flutter/material.dart';

class ImageForPick extends StatefulWidget {
  String? filename;
  String? filepath;
  String? extension;
  int? counter;
  VoidCallback? func;
  ImageForPick(
      {this.filename, this.filepath, this.extension, this.func, this.counter});

  @override
  State<StatefulWidget> createState() => _ImageForPick();
}

class _ImageForPick extends State<ImageForPick> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: 100,
          height: 100,
          child: Image.file(
            File(widget.filepath!),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: Container(
                width: 20,
                height: 20,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor: isSelected == true ? colorMain :  Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.white, width: 2))),
                    onPressed: () {
                      setState(() {
                        isSelected = !isSelected;
                      });
                      //widget.func.call();
                    },
                    child: (widget.counter != null && widget.counter! > 0)
                        ? Text(widget.counter.toString(),
                            style: TextStyle(color: Colors.white))
                        : Container())))
      ],
    )
    );
    
  }
}
