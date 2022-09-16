import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectSmartPU extends StatefulWidget{
  String name;
  String number;
  String address;

  ObjectSmartPU({required this.name, required this.address, required this.number});
  @override
  State<StatefulWidget> createState() => _ObjectSmartPU();
}

class _ObjectSmartPU extends State<ObjectSmartPU>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
        ],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Text(widget.name)
        ],
      ),
    );
  }
}