import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Chats();
}

class _Chats extends State<Chats>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Chat page")
        ],
      ),
    );
  }
}