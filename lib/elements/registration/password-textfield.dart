import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            return null;
          },
          autofocus: false,
          obscureText: obscureText,
          decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder))),
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
