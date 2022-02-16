import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../consts.dart';

class MaskInput extends StatefulWidget{

  MaskInput({Key? key, required this.formatter, required this.hint, required this.textController}) : super(key: key);
  final TextEditingController textController;
  final MaskTextInputFormatter formatter;
  final String hint;

  @override
  State<StatefulWidget> createState() => _MaskInput();
}

class _MaskInput extends State<MaskInput>{
  @override
  Widget build(BuildContext context) {
    return buildTextField(widget.textController, widget.formatter, widget.hint);
  }

  Widget buildTextField(
      TextEditingController textEditingController,
      MaskTextInputFormatter textInputFormatter,
      String hint){
    return TextFormField(
      controller: textEditingController,
      inputFormatters: [textInputFormatter],
      keyboardType: TextInputType.phone,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        hintText: hint,
          border: OutlineInputBorder(
              borderSide:
              BorderSide(color: inputBorder))
      ),
    );
  }

}