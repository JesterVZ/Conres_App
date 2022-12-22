import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
/* 
password-textfield.dart
Виджет для ввоа пароля

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class PasswordTextField extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  PasswordTextField({required this.controller, required this.hintText});
  @override
  State<StatefulWidget> createState() => _PasswordTextField();
}

class _PasswordTextField extends State<PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите пароль";
            }
            if(value.length <=3){
              return "Пароль слишком короткий";
            }
            return null;
          },
          autofocus: false,
          obscureText: obscureText,
          decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10))),
        ),
        Positioned(
          right: 15,
          top: 15,
          child: GestureDetector(
            onTap: (){
              setState(() {
                obscureText = !obscureText;
              });
            },
          child: Container(
            width: 30,
            height: 30,
            child: SvgPicture.asset('assets/eye.svg', color: profileLabelColor),
          ),
        ),
        )
        
      ],
    );
  }
}
