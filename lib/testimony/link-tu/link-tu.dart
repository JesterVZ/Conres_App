import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';

import '../../consts.dart';

class LinkTu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LinkTu();
}

class _LinkTu extends State<LinkTu> {
  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    TextEditingController numberTuColtroller = TextEditingController();
    TextEditingController nameTuColtroller = TextEditingController();
    TextEditingController addressTuColtroller = TextEditingController();
    return MainForm(
        header: HeaderNotification(text: "Привязать ТУ", canGoBack: true),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    left: defaultSidePadding, right: defaultSidePadding),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: DefaultInput(
                          labelText: "Номер ТУ",
                          hintText: "Номер ТУ",
                          keyboardType: TextInputType.number,
                          controller: numberTuColtroller),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: DefaultInput(
                          labelText: "Наименование ТУ",
                          hintText: "Наименование ТУ",
                          keyboardType: TextInputType.text,
                          controller: nameTuColtroller),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: DefaultInput(
                          labelText: "Адрес ТУ",
                          hintText: "Адрес ТУ",
                          keyboardType: TextInputType.text,
                          controller: addressTuColtroller),
                    ),
                  ],
                ))),
        footer: DefaultButton(
          isGetPadding: true,
          onPressed: () {},
          text: "Отправить запрос",
        ),
        onRefrash: _refrash);
  }
}
