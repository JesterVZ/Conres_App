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
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: inputBorder, width: 2),
                  )),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: colorMain,
                      onPrimary: Colors.white,
                      onSurface: colorMain
                    )
                  ),
                   child: child!);
              },
              locale: Locale('ru'),
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    );
  }
}