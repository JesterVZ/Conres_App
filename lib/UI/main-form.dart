import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../elements/header/header-notification.dart';

class MainForm extends StatefulWidget {
  Widget body;
  Widget header;
  MainForm({
    required this.header,
    required this.body
  });
  @override
  State<StatefulWidget> createState() => _MainForm();
}

class _MainForm extends State<MainForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: 
        Column(children: [
          Container(
              margin: EdgeInsets.only(top: 52),
              padding: EdgeInsets.only(
                  left: defaultSidePadding,
                  right: defaultSidePadding,
                  bottom: 12),
              child: widget.header),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                padding: EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding),
                child: widget.body)
              )
            ))
        ]));
  }
}
