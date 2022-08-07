

import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpansionTileElement extends StatefulWidget {
  ExpansionTileElement({this.body, this.header, this.tileText});
  Widget? header;
  Widget? tileText;
  Widget? body;
  @override
  State<StatefulWidget> createState() => _ExpansionTileElement();
}

class _ExpansionTileElement extends State<ExpansionTileElement> {
  bool canLogin = false;
  bool claimNotification = false;
  bool ticketNotification = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1, bottom: 10),
      //padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: widget.header),
          ExpansionTile(
            maintainState: true,
            
            title: widget.tileText ?? const Text(""),
            children: [
              Padding(
              padding: EdgeInsets.all(20),
              child: widget.body ?? const Text("")),
              
            ],
          )
        ],
      ),
    );
  }
}
