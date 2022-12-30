import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../consts.dart';
import '../validation/validation.dart';
/* 
masks.dart
Устаревший файл с масками
TODO deprecated

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class MaskInput extends StatefulWidget {
  MaskInput(
      {Key? key,
      required this.formatter,
      required this.hint,
      required this.textController,
      required this.type})
      : super(key: key);
  final TextEditingController textController;
  final MaskTextInputFormatter formatter;
  final String hint;
  final String type;

  @override
  State<StatefulWidget> createState() => _MaskInput();
}

class _MaskInput extends State<MaskInput> {
  bool _isPhoneValidate = false;
  bool _isInnValidate = false;
  bool _isSnilsValidate = false;
  bool _isOfrnipValidate = false;
  bool _isOgrnValidate = false;
  bool _isEmailValidate = false;
  bool _isKppValidate = false;
  bool _islsValidate = false;

  @override
  Widget build(BuildContext context) {
    return buildTextField(widget.textController, widget.formatter, widget.hint);
  }

  Widget buildTextField(TextEditingController textEditingController,
      MaskTextInputFormatter textInputFormatter, String hint) {
    switch (widget.type) {
      case "phone":
        return TextFormField(
          style: TextStyle(color: _isPhoneValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите телефон";
            } else if (_isPhoneValidate == false) {
              return "Телефон некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.phone,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder, width: 5.0),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isPhoneValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _isPhoneValidate = isPhoneValidate(value);
            });
          },
        );
      case "inn":
        return TextFormField(
          style: TextStyle(color: _isInnValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите ИНН";
            } else if (_isInnValidate == false) {
              return "ИНН некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.phone,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isInnValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _isInnValidate = isInnValidate(value);
            });
          },
        );
      case "inn(ul)":
        return TextFormField(
          style: TextStyle(color: _isInnValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите ИНН";
            } else if (_isInnValidate == false) {
              return "ИНН некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.phone,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isInnValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _isInnValidate = isInnIpValidate(value);
            });
          },
        );
      case "snils":
        return TextFormField(
          style: TextStyle(color: _isSnilsValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите СНИЛС";
            } else if (_isSnilsValidate == false) {
              return "СНИЛС некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.phone,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isSnilsValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _isSnilsValidate = isSnilsValidate(value);
            });
          },
        );
      case "ogrn":
        return TextFormField(
          style: TextStyle(color: _isOgrnValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите ОГРН";
            } else if (_isOgrnValidate == false) {
              return "ОГРН некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.number,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isOgrnValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _isOgrnValidate = isOgrnValidate(value);
            });
          },
        );
      case "ofrnip":
        return TextFormField(
          style:
              TextStyle(color: _isOfrnipValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите ОГРНИП";
            } else if (_isOfrnipValidate == false) {
              return "ОГРНИП некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.phone,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isOfrnipValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _isOfrnipValidate = isOgrnipValidate(value);
            });
          },
        );
      case "ofrnip(ul)":
        return TextFormField(
          style:
              TextStyle(color: _isOfrnipValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите ОГРНИП";
            } else if (_isOfrnipValidate == false) {
              return "ОГРНИП некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.phone,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isOfrnipValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _isOfrnipValidate = isOgrnipUlValidate(value);
            });
          },
        );
      case "email":
        return TextFormField(
          style: TextStyle(color: _isEmailValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите Email";
            } else if (_isEmailValidate == false) {
              return "Email некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.phone,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isEmailValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _isEmailValidate = isEmailValidate(value);
            });
          },
        );
      case "kpp":
        return TextFormField(
          style: TextStyle(color: _isKppValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите КПП";
            } else if (_isKppValidate == false) {
              return "КПП некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.phone,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isKppValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _isKppValidate = isKppValidate(value);
            });
          },
        );
      case "ls":
        return TextFormField(
          style: TextStyle(color: _islsValidate ? Colors.green : Colors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Введите ЛС";
            } else if (_islsValidate == false) {
              return "ЛС некорректен";
            }
            return null;
          },
          controller: textEditingController,
          inputFormatters: [textInputFormatter],
          keyboardType: TextInputType.phone,
          autocorrect: false,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: inputBorder),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _islsValidate ? Colors.green : Colors.red),
                  borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            setState(() {
              _islsValidate = isLsvalidate(value);
            });
          },
        );
    }
    return TextFormField(
      controller: textEditingController,
      inputFormatters: [textInputFormatter],
      keyboardType: TextInputType.phone,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderSide: BorderSide(color: inputBorder)),
      ),
    );
  }
}
