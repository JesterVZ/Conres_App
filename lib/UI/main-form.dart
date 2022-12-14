import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../elements/header/header-notification.dart';

class MainForm extends StatefulWidget {
  Widget body;
  Widget header;
  Widget? footer;
  double footerHeight;
  double footerPadding;

  Future<void> Function() onRefrash;
  MainForm(
      {required this.header,
      required this.body,
      this.footer,
        this.footerHeight = 90,
        this.footerPadding = 17.5,
      required this.onRefrash});
  @override
  State<StatefulWidget> createState() => _MainForm();
}

class _MainForm extends State<MainForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(children: [
          Container(
              margin: EdgeInsets.only(top: 52),
              padding: EdgeInsets.only(
                  left: defaultSidePadding,
                  right: defaultSidePadding,
                  bottom: 12),
              child: widget.header),
          Expanded(
              child: Scrollbar(
                  child: RefreshIndicator(
                      onRefresh: widget.onRefrash, child: widget.body))),
          Visibility(
            visible: widget.footer != null ? true : false,
            child: Container(
              height: widget.footerHeight,
              padding: EdgeInsets.only(top: widget.footerPadding, bottom: widget.footerPadding),
              child: widget.footer,
            ),
          )
        ]));
  }
}
