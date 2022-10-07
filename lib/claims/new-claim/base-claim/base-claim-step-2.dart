import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../UI/main-form.dart';
import '../../../consts.dart';
import '../../../elements/header/header.dart';

class BaseClaimStep2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseClaimStep2();
}

class _BaseClaimStep2 extends State<BaseClaimStep2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textarea = TextEditingController();
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Заявление о необходимости снятия показаний существующего прибора учета",
                            style: TextStyle(color: colorGray, fontSize: 16.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Введите текст!";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          controller: textarea,
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintText: "Ваше заявление",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: inputBorder, width: 5.0),
                                  borderRadius: BorderRadius.circular(10))),
                        )
                      ],
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 55.0,
                        child: ElevatedButton(
                          
                            onPressed: () {
                              Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BaseClaimStep2(
                                            )));


                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BaseClaimStep2(
                                            )));
                              }
                            },
                            child: Text(
                              "Отправить",
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: colorMain))),
                  ],
                ))));
  }
}
