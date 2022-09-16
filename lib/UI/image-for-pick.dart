import 'dart:io';

import 'package:flutter/material.dart';

class ImageForPick extends StatefulWidget{
  String? filename;
  String? filepath;
  String? extension;
  int? counter;
  VoidCallback func;
  ImageForPick({this.filename, this.filepath, this.extension, required this.func, this.counter});

  @override
  State<StatefulWidget> createState() => _ImageForPick();
}

class _ImageForPick extends State<ImageForPick>{
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
              child: Image.file(File(widget.filepath!)),
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
                        backgroundColor: Colors.transparent,
                        
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.white, width: 2))),
                    onPressed: () {
                      widget.func.call();
                    },
                    child: widget.counter! > 0 ? Text(widget.counter.toString(), style: TextStyle(color: Colors.white)) : Container())))
      ],
    ));
  }
}