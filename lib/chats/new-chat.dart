import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../elements/header/header-notification.dart';

class NewChat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewChat();
}

class _NewChat extends State<NewChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          child: Column(children: [
        Container(
            padding: EdgeInsets.only(
                left: defaultSidePadding, right: defaultSidePadding),
            height: 100,
            child: HeaderNotification(
              text: "Новое обращение",
            ))
        
      ]))
    ]));
  }
}
