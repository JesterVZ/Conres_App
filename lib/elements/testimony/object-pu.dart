import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectPU extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ObjectPU();
}

class _ObjectPU extends State<ObjectPU>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(17),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]
        ),
      ),
    );
  }
}