import 'package:conres_app/UI/default-button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

class SelectObjectDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectObjectDialog();
}

class _SelectObjectDialog extends State<SelectObjectDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Выберите объект"),
        content: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
              height: 280,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Expanded(
                child: Column(children: []),
              )),
        ));
  }
}
