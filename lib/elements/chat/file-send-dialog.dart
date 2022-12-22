import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/* 
file-send-dialog.dart
Диалоговое окно загрузки файлов

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class FileSendDialog extends StatefulWidget{
  VoidCallback createPhoto;
  VoidCallback pickFile;
  FileSendDialog({required this.createPhoto, required this.pickFile});
  @override
  State<StatefulWidget> createState() => _FileSendDialog();
}

class _FileSendDialog extends State<FileSendDialog>{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Загрузка файлов", textAlign: TextAlign.center,),
      content: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  widget.createPhoto.call();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                                          backgroundColor: colorMain,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: buttonRadius)),
                child: const Text("Сделать фото")),
                ElevatedButton(
                onPressed: (){
                  widget.pickFile.call();
                  Navigator.pop(context);
                }, 
                style: ElevatedButton.styleFrom(
                                          backgroundColor: colorMain,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: buttonRadius)),
                child: const Text("Взять из галереи"))
            ],
          )
        ),
        
      ),
    );
  }
}