import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:conres_app/testimony/tu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Services/profile-service.dart';
import '../../UI/default-button.dart';

/* 
object-pu.dart
Виджет объекта

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class ObjectPU extends StatefulWidget {
  ObjectPuModel objectPuModel;
  Function remove;
  Function refrash;
  Function edit;
  ObjectPU(
      {required this.objectPuModel,
      required this.remove,
      required this.refrash,
      required this.edit});
  @override
  State<StatefulWidget> createState() => _ObjectPU();
}

class _ObjectPU extends State<ObjectPU> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ProfileService? profileService;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.width * 0.04;
    return Padding(
        padding: EdgeInsets.only(
            left: defaultSidePadding, right: defaultSidePadding),
        child: Container(
          padding: EdgeInsets.all(17),
          margin: EdgeInsets.only(top: 14, bottom: 14),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFD4D9E6),
                  spreadRadius: 5,
                  blurRadius: 16,
                  offset: Offset(0, 8),
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.fromLTRB(11, 6, 11, 6),
                    decoration: BoxDecoration(
                        color: widget.objectPuModel.status == "0"
                            ? redColor
                            : (widget.objectPuModel.status == "1" ||
                                    widget.objectPuModel.status == "3")
                                ? yellowColor
                                : greenColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      widget.objectPuModel.status == "0"
                          ? "Заявка на привязку ПУ отклонена"
                          : widget.objectPuModel.status == "1"
                              ? "Проходит проверку на добавление"
                              : widget.objectPuModel.status == "2"
                                  ? "Активный"
                                  : "Проходит проверку на изменение",
                      style: TextStyle(color: Colors.white, fontSize: textSize),
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: widget.objectPuModel.status == "0" ? true : false,
                    child: Material(
                        child: InkWell(
                      onTap: () {
                        widget.remove.call(widget.objectPuModel);
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
                margin: EdgeInsets.only(bottom: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Наименование объекта",
                        style: TextStyle(
                          color: colorGrayClaim,
                          fontSize: 15,
                        )),
                    Text(
                      widget.objectPuModel.name!,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Адрес объекта:",
                        style: TextStyle(color: colorGrayClaim, fontSize: 15)),
                    Text(widget.objectPuModel.address!)
                  ],
                ),
              ),
              Visibility(
                  visible: widget.objectPuModel.comments != null ? true : false,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Комментарий",
                              style: TextStyle(
                                  color: profileLabelColor, fontSize: 15)),
                          Text(
                              widget.objectPuModel.comments == null
                                  ? ""
                                  : widget.objectPuModel.comments!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15))
                        ],
                      ))),
              Row(
                children: [
                  DefaultButton(
                      fontSize: (MediaQuery.of(context).size.width) * 0.04,
                      textColor: colorMain,
                      text: "Редактировать",
                      onPressed: () {
                        nameController.text = widget.objectPuModel.name!;
                        addressController.text = widget.objectPuModel.address!;
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.noHeader,
                          animType: AnimType.bottomSlide,
                          headerAnimationLoop: false,
                          btnOk: DefaultButton(
                            isGetPadding: false,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ObjectPuModel newObject = ObjectPuModel(
                                    object_id: widget.objectPuModel.object_id,
                                    name: nameController.text,
                                    address: addressController.text,
                                    account_id: widget.objectPuModel.account_id,
                                    date_added: widget.objectPuModel.date_added,
                                    hidden: widget.objectPuModel.hidden,
                                    status: widget.objectPuModel.status,
                                    comments: widget.objectPuModel.comments);
                                widget.edit.call(newObject);
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
                              height: 280,
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
                                            "Редактировать объект",
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: DefaultInput(
                                            labelText: "Наименование объекта",
                                            keyboardType: TextInputType.text,
                                            hintText: "Дом",
                                            validatorText:
                                                "Введите наименование",
                                            controller: nameController),
                                      ),
                                      DefaultInput(
                                          labelText: "Адрес объекта",
                                          keyboardType: TextInputType.text,
                                          hintText:
                                              "Город, Улица, Дом, Квартира",
                                          validatorText: "Введите адрес",
                                          controller: addressController),
                                    ]),
                              )),
                        ).show();
                      },
                      isGetPadding: false,
                      backgroundColor: messageColor,
                      width: (MediaQuery.of(context).size.width / 2.5)),
                  const Spacer(),
                  DefaultButton(
                      fontSize: (MediaQuery.of(context).size.width) * 0.04,
                      textColor: colorMain,
                      text: "Подробнее",
                      onPressed: () {
                        profileService!.object_id =
                            widget.objectPuModel.object_id;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageTU(
                                      currentPU: widget.objectPuModel,
                                    )));
                      },
                      isGetPadding: false,
                      backgroundColor: messageColor,
                      width: (MediaQuery.of(context).size.width / 2.5)),
                ],
              )
            ],
          ),
        ));
  }

  @override
  void didChangeDependencies() {
    profileService ??= DependencyProvider.of(context)!.profileService;
    super.didChangeDependencies();
  }
}
