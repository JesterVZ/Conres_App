import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NotificationListPage();
}

class _NotificationListPage extends State<NotificationListPage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Здесь будут уведомления")
      ),
    );
  }

}