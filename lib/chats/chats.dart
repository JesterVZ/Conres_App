import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../elements/dropdown.dart';

class Chats extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Chats();
}

class _Chats extends State<Chats>{
  List items = ["1", "2", "3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}