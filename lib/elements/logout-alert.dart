import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login/login-main.dart';

class LogoutAlert extends StatefulWidget{
  String title;
  String text;

  LogoutAlert({Key? key, required this.title, required this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LogoutAlert();
}

class _LogoutAlert extends State<LogoutAlert>{
  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
        title: Text(widget.title),
        content: Text(widget.text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false),
            child: const Text('OK'),
          ),
        ]
    );
  }
}