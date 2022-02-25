import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert extends StatefulWidget{
  String title;
  String text;

  Alert({Key? key, required this.title, required this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Alert();
}

class _Alert extends State<Alert>{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.title),
        content: Text(widget.text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ]
    );
  }
}