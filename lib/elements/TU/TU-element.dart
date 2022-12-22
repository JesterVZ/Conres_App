import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/model/TU.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../UI/default-button.dart';
import '../../UI/default-input.dart';
import '../../consts.dart';
import '../../testimony/tu-info.dart';
import '../full-profile/ExpansionTileElement.dart';
/* 
TU-element.dart
Виджет точки учета

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class TuElement extends StatefulWidget {
  final TuModel? currentTu;
  List<TuModel> TuPoints;
  ValueChanged<TuModel> remove;
  Function edit;

  TuElement(
      {required this.currentTu,
      required this.remove,
      required this.edit,
      required this.TuPoints});
  @override
  State<StatefulWidget> createState() => _TuElement();
}

class _TuElement extends State<TuElement> {
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.width * 0.04;
    return Padding(
        padding: EdgeInsets.only(
            left: defaultSidePadding, right: defaultSidePadding),
        child: Container(
            margin: const EdgeInsets.only(top: 14, bottom: 14),
            child: ExpansionTileElement(
                tileText: const Text("Подробнее"),
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.fromLTRB(11, 6, 11, 6),
                          decoration: BoxDecoration(
                              color: widget.currentTu!.status == "0"
                                  ? redColor
                                  : (widget.currentTu!.status == "1" ||
                                          widget.currentTu!.status == "3")
                                      ? yellowColor
                                      : greenColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            widget.currentTu!.status == "0"
                                ? "Заявка на привязку ПУ отклонена"
                                : widget.currentTu!.status == "1"
                                    ? "Проходит проверку на добавление"
                                    : widget.currentTu!.status == "2"
                                        ? "Активный"
                                        : "Проходит проверку на изменение",
                            style: TextStyle(color: Colors.white, fontSize: textSize),
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                          visible:
                              widget.currentTu!.status == "0" ? true : false,
                          child: Material(
                              child: InkWell(
                            onTap: () {
                              widget.remove.call(widget.currentTu!);
                            },
                            child: SvgPicture.asset(
                              'assets/remove-file.svg',
                              color: colorGrayClaim,
                            ),
                          )),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("№ точки учёта:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentTu!.number!,
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),

                          //StatusElement(status: widget.currentClaim.status!),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("Наименование ТУ:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentTu!.name!,
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),

                          //StatusElement(status: widget.currentClaim.status!),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("Адрес ТУ:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentTu!.address!,
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),

                          //StatusElement(status: widget.currentClaim.status!),
                        ],
                      ),
                    ),
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: EdgeInsets.only(bottom: 12, top: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            numberController.text = widget.currentTu!.number!;
                            nameController.text = widget.currentTu!.name!;
                            addressController.text = widget.currentTu!.address!;
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.bottomSlide,
                              headerAnimationLoop: false,
                              btnOk: DefaultButton(
                                isGetPadding: false,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    TuModel newTu = TuModel(
                                        point_id: widget.currentTu!.point_id,
                                        object_id: widget.currentTu!.object_id,
                                        name: nameController.text,
                                        number: numberController.text,
                                        address: addressController.text,
                                        date_added:
                                            widget.currentTu!.date_added,
                                        hidden: widget.currentTu!.hidden,
                                        status: widget.currentTu!.status,
                                        comments: widget.currentTu!.comments);
                                    widget.edit.call(newTu);
                                    Navigator.pop(context);
                                  }
                                },
                                text: "Принять",
                              ),
                              body: Container(
                                  padding: EdgeInsets.only(
                                      left: defaultSidePadding,
                                      top: 5,
                                      right: defaultSidePadding),
                                  height: 350,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            child: const Text(
                                                "Редактировать ТУ",
                                                style: TextStyle(fontSize: 20)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            child: DefaultInput(
                                                labelText: "Номер ТУ",
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: "Номер ТУ",
                                                validatorText:
                                                    "Введите номер ТУ",
                                                controller: numberController),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            child: DefaultInput(
                                                labelText: "Наименование ТУ",
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: "Наименование ТУ",
                                                validatorText:
                                                    "Введите наименование ТУ",
                                                controller: nameController),
                                          ),
                                          DefaultInput(
                                              labelText: "Адрес ТУ",
                                              keyboardType: TextInputType.text,
                                              hintText:
                                                  "Город, Улица, Дом, Квартира",
                                              validatorText: "Введите адрес",
                                              controller: addressController),
                                        ]),
                                  )),
                            ).show();
                          
                          },
                          child:  Text("Редактировать",
                              style:
                                  TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: EdgeInsets.only(bottom: 12, top: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TuFullInfo(
                                          currentTu: widget.currentTu,
                                          TuPoints: widget.TuPoints,
                                        )));
                          },
                          child: Text("Подробнее",
                              style: TextStyle(color: colorMain, fontSize: MediaQuery.of(context).size.width * 0.05)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: messageColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                  ],
                ))));
  }
}
