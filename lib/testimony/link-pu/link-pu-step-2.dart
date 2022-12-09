import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/testimony/link-pu/link-pu-step-3.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../UI/default-button.dart';
import '../../UI/main-form.dart';
import '../../consts.dart';
import '../../elements/PU/list-element.dart';
import '../../elements/header/header-notification.dart';
import '../../elements/testimony/select-object-doalog.dart';
import '../../model/object_pu.dart';

class LinkPUStep2 extends StatefulWidget {
  ObjectPuModel crrentPu;
  LinkPUStep2({Key? key, required this.crrentPu}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkPUStep2();
}

class _LinkPUStep2 extends State<LinkPUStep2> {
  List dropdownTuList = [];
  Map selectedTu = {};
  bool isGotTu = false;
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<void> _refrash() async {}

  void selectPoint(value) {
    if (selectedTu.containsKey(value['id']) == false) {
      setState(() {
        final point = {value['id']: value['label']};
        selectedTu.addEntries(point.entries);
      });
    }
  }

  @override
  void initState() {
    for (int i = 0; i < tuFullList!.length; i++) {
      if (tuFullList![i].object_id == widget.crrentPu.object_id) {
        isGotTu = true;
        dropdownTuList.add({
          'id': tuFullList![i].point_id,
          'label': tuFullList![i].name,
          'value': tuFullList![i].name
        });
      }
    }
    if (dropdownTuList.isEmpty) {
      dropdownTuList.add({'label': '', 'value': ''});
    }

    super.initState();
  }

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
                    "Выберите или укажите новую точку учета",
                    style: TextStyle(
                        color: colorMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text("Точка учёта", style: labelTextStyle),
                Visibility(
                    visible: isGotTu,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          child: CoolDropdown(
                            resultHeight: 55,
                            resultTS: TextStyle(
                              fontSize: 20,
                              color: colorMain,
                            ),
                            resultBD: BoxDecoration(
                              color: messageColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            selectedItemBD: BoxDecoration(
                              color: messageColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            selectedItemTS: TextStyle(
                              fontSize: 20,
                              color: colorMain,
                            ),
                            dropdownBD: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 49, 49, 49)
                                        .withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(0, 1),
                                  ),
                                ]),
                            dropdownWidth:
                                MediaQuery.of(context).size.width - 50,
                            resultWidth: MediaQuery.of(context).size.width,
                            dropdownList: dropdownTuList,
                            onChange: (value) {
                              selectPoint(value);
                            },
                            defaultValue: dropdownTuList[0],
                          ),
                        ),
                        Container(
                            constraints: BoxConstraints(maxHeight: 100),
                            //height: 100,
                            child: Flex(
                              direction: Axis.vertical,
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: selectedTu.length,
                                        itemBuilder: (context, int index) {
                                          return ListElement(
                                              text: selectedTu.values
                                                  .elementAt(index));
                                        }))
                              ],
                            )),
                        DefaultButton(
                            text: "Добавить новую ТУ",
                            onPressed: () {},
                            isGetPadding: false)
                      ],
                    )),
                Visibility(
                    visible: !isGotTu,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 12, top: 15),
                        child: DefaultInput(
                            labelText: "Номер ТУ",
                            hintText: "Номер ТУ",
                            keyboardType: TextInputType.text,
                            controller: numberController),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: DefaultInput(
                            labelText: "Наименование ТУ",
                            hintText: "Наименование ТУ",
                            keyboardType: TextInputType.text,
                            controller: nameController),
                      ),
                      DefaultInput(
                          labelText: "Адрес ТУ",
                          hintText: "Адрес ТУ",
                          keyboardType: TextInputType.text,
                          controller: addressController)
                    ]))
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LinkPUStep3()));
                  },
                  child: const Text("Далее", style: TextStyle(fontSize: 18)),
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
