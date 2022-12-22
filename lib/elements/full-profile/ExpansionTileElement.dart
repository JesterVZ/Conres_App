import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../UI/ExpansionTileCuston.dart';
/* 
ExpansionTileElement.dart
Рскрывающаяся панель

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class ExpansionTileElement extends StatefulWidget {
  ExpansionTileElement({Key? key, this.body, this.header, this.tileText});
  Widget? header;
  Widget? tileText;
  Widget? body;
  @override
  State<StatefulWidget> createState() => ExpansionTileElementState();
}

class ExpansionTileElementState extends State<ExpansionTileElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1, bottom: 10),
      //padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFFD4D9E6),
                                        spreadRadius: 5,
                                        blurRadius: 16,
                                        offset: Offset(0, 8),
                                      )]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(20), child: widget.header),
          ExpansionTileOwm(
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
