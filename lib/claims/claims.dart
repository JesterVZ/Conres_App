import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Claims extends StatefulWidget{
  const Claims({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Claims();
}

class _Claims extends State<Claims>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Claims page")
        ],
      ),
    );
  }
}