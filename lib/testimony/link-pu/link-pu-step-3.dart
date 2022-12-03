import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/elements/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../UI/default-button.dart';
import '../../UI/main-form.dart';
import '../../consts.dart';
import '../../elements/PU/list-element.dart';
import '../../elements/header/header-notification.dart';
import '../../elements/testimony/select-object-doalog.dart';

class LinkPUStep3 extends StatefulWidget {
  const LinkPUStep3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkPUStep3();
}

class _LinkPUStep3 extends State<LinkPUStep3> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController tariffController = TextEditingController();
  TextEditingController multipler = TextEditingController();
  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return MainForm(
        header: HeaderNotification(text: "Привязать ПУ", canGoBack: true),
        body: Padding(
            padding: EdgeInsets.only(
                left: defaultSidePadding, right: defaultSidePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Укажите информацию о ПУ",
                    style: TextStyle(
                        color: colorMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: DefaultInput(
                        labelText: "Наименование ПУ",
                        keyboardType: TextInputType.text,
                        hintText: "Наименование ПУ",
                        controller: nameController)),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: DefaultInput(
                      labelText: "Номер ПУ",
                      keyboardType: TextInputType.text,
                      hintText: "Номер ПУ",
                      controller: numberController),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: CustomDropDown(
                    title: "Тип ПУ",
                    selectedItem: typeController,
                    items: const ["Электроэнергия"],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: CustomDropDown(
                    title: "Тарифная зона ПУ",
                    selectedItem: tariffController,
                    items: const ["Двухтарифный"],
                  ),
                ),
                DefaultInput(
                    labelText: "Множитель показаний",
                    keyboardType: TextInputType.text,
                    hintText: "Множитель показаний",
                    controller: multipler),
              ],
            )),
        footer: Row(
          children: [
            Container(
                padding: EdgeInsets.only(
                  left: defaultSidePadding,
                ),
                width: 160,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Назад",
                      style: TextStyle(fontSize: 18, color: colorMain)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: messageColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                )),
            const Spacer(),
            Container(
                padding: EdgeInsets.only(right: defaultSidePadding),
                width: 160,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  child:
                      const Text("Отправить", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorMain,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ))
          ],
        ),
        onRefrash: _refrash);
  }
}
