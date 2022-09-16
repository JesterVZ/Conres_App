import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmartPU extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _SmartPU();
}

class _SmartPU extends State<SmartPU>{
  @override
  Widget build(BuildContext context) {
    return MainForm(
      header: HeaderNotification(
        text: "Показания умных ПУ"), 
        body: Column(
          children: [

          ]));
  }
}