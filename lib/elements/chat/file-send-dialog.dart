import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      title: const Text("Загрузка файлов"),
      content: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  widget.createPhoto.call();
                }, 
                child: const Text("Сделать фото")),
                ElevatedButton(
                onPressed: (){
                  widget.pickFile.call();
                }, 
                child: const Text("Взять из галереи"))
            ],
          )
        ),
        
      ),
    );
  }
}