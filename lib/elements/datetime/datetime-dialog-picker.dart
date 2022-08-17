import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../consts.dart';

class BasicDateField extends StatelessWidget {
  DateFormat format;
  TextEditingController controller;

  BasicDateField({Key? key, required this.controller, required this.format}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DateTimeField(
        controller: controller,
        format: format,
        decoration: InputDecoration(
            hintText: "01.01.2020",
            border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder, width: 5.0),
                  borderRadius: BorderRadius.circular(10))),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    );
  }
}