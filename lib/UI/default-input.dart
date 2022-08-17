import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class DefaultInput extends StatefulWidget {
  String? labelText;
  String? hintText;
  String? validatorText;
  TextInputType? keyboardType;
  TextEditingController controller;
  DefaultInput(
      {required this.labelText, required this.keyboardType, this.hintText, this.validatorText, required this.controller});
  @override
  State<StatefulWidget> createState() => _DefaultInput();
}

class _DefaultInput extends State<DefaultInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(family, style: TextStyle(color: colorGray, fontSize: 16.0)),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.validatorText;
            }
            return null;
          },
          textCapitalization: TextCapitalization.sentences,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder, width: 5.0),
                  borderRadius: BorderRadius.circular(10))),
        )
      ],
    );
  }
}
