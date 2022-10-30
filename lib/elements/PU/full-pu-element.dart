import 'package:flutter/cupertino.dart';

import '../../consts.dart';
import '../full-profile/ExpansionTileElement.dart';

class FullPuElement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullPuElement();
}

class _FullPuElement extends State<FullPuElement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: defaultSidePadding, right: defaultSidePadding),
        child: Container(
            margin: EdgeInsets.only(top: 14, bottom: 14),
            child: ExpansionTileElement(
              tileText: const Text("Параметры"),
              header: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("data")]),
            )));
  }
}
