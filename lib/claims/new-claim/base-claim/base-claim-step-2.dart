import 'package:flutter/cupertino.dart';

import '../../../UI/main-form.dart';
import '../../../consts.dart';
import '../../../elements/header/header.dart';

class BaseClaimStep2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BaseClaimStep2();
}

class _BaseClaimStep2 extends State<BaseClaimStep2>{
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            header: HeaderRow(text: claimStep2, fontSize: 24),
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  
                ],
              )
            )));
  }
}