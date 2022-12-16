import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../consts.dart';
import '../validation/validation.dart';

class DefaultInput extends StatefulWidget {
  String? labelText;
  String? hintText;
  String? validatorText;
  String? regExp;
  TextInputType? keyboardType;
  bool obscureText;
  TextEditingController controller;
  EdgeInsetsGeometry? margin;
  MaskTextInputFormatter? textInputFormatter;
  
  DefaultInput(
      {required this.labelText,
      required this.keyboardType,
      this.hintText,
      this.validatorText,
      this.textInputFormatter,
      this.margin = const EdgeInsets.only(bottom: 18),
      this.obscureText = false,
      this.regExp,
      required this.controller});
  @override
  State<StatefulWidget> createState() => _DefaultInput();
}

class _DefaultInput extends State<DefaultInput> {
  bool _isValueValidate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: Text(widget.labelText!,
            style: TextStyle(color: colorGray, fontSize: 16.0))
        ),
        TextFormField(
          style: TextStyle(color: _isValueValidate ? Colors.green : Colors.black),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.validatorText;
            }
            return null;
          },
          inputFormatters: widget.textInputFormatter != null ? [widget.textInputFormatter!] : [],
          textCapitalization: TextCapitalization.sentences,
          obscureText: widget.obscureText,
          controller: widget.controller,
          keyboardType: widget.keyboardType,

          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: inputBorder),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: _isValueValidate ? Colors.green : inputBorder, width: 2),
                  ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colorMain, width: 2),
                  ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  )),
          onChanged: (value) {
            if(widget.regExp != null){
              setState(() {
              _isValueValidate = _validateValue(value);
            });
            }
            
          },
        )
      ],
    )
    );
    
  }
  bool _validateValue(String value){
    return RegExp(widget.regExp!).hasMatch(value);
  }
}
