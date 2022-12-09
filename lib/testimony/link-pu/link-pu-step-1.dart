import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/PU/list-element.dart';
import 'package:conres_app/testimony/link-pu.dart';
import 'package:conres_app/testimony/link-pu/link-pu-step-2.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Services/link-pu-service.dart';
import '../../UI/default-input.dart';
import '../../elements/PU/added-object.dart';
import '../../elements/header/header-notification.dart';
import '../../elements/testimony/object-pu-dialog.dart';
import '../../elements/testimony/select-object-doalog.dart';
import '../../model/object_pu.dart';

class LinkPUStep1 extends StatefulWidget {
  LinkPUStep1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkPUStep1();
}

class _LinkPUStep1 extends State<LinkPUStep1> {
  List dropdownObjectsList = [];
  LinkPuService? linkPuService;

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isAddNewObject = false;
  ObjectPuModel? newObject = ObjectPuModel();
  ObjectPuModel? selectedObject;

  Future<void> _refrash() async {}

  void selectObject(value) {
    setState(() {
      //final point = {value['id']: value['label']};
      //selectedObjects.addEntries(point.entries);
      selectedObject = ObjectPuModel(object_id: value['id']);
    });
  }

  void removeObject(ObjectPuModel object) {
    setState(() {
      isAddNewObject = false;
    });
  }

  @override
  void initState() {
    //tuFromObject = {for (var e in tuFullList!) e.point_id!: e};

    for (int i = 0; i < objectsList!.length; i++) {
      dropdownObjectsList.add({
        'id': objectsList![i].object_id,
        'label': objectsList![i].name,
        'value': objectsList![i].name
      });
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
                    "Выберите или введите новый объект",
                    style: TextStyle(
                        color: colorMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text("Объект", style: labelTextStyle),
                Visibility(
                  visible: isAddNewObject == true ? false : true,
                  child: Container(
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
                      dropdownWidth: MediaQuery.of(context).size.width - 50,
                      resultWidth: MediaQuery.of(context).size.width,
                      dropdownList: dropdownObjectsList,
                      onChange: (value) {
                        selectObject(value);
                      },
                      //defaultValue: dropdownObjectsList[0],
                    ),
                  ),
                ),
                Visibility(
                    visible: isAddNewObject == true ? true : false,
                    child:
                        AddedObject(object: newObject!, remove: removeObject)),
                Visibility(
                    visible: isAddNewObject == true ? false : true,
                    child: DefaultButton(
                        text: "Добавить новый объект",
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.noHeader,
                            animType: AnimType.bottomSlide,
                            headerAnimationLoop: false,
                            btnOk: DefaultButton(
                              isGetPadding: false,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  newObject = ObjectPuModel(
                                      name: nameController.text,
                                      address: addressController.text);
                                  setState(() {
                                    isAddNewObject = true;
                                  });
                                  nameController.text = "";
                                  addressController.text = "";

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
                                              "Добавить новый объект",
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
                        isGetPadding: false))
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
                  child: Text("Отменить",
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
                  onPressed: (selectedObject != null || isAddNewObject == true)
                      ? () {
                          if (isAddNewObject == false) {
                            linkPuService!.new_object_id =
                                selectedObject!.object_id;
                          } else {
                            linkPuService!.new_object_id = '0';
                            linkPuService!.new_object_name =
                                nameController.text;
                            linkPuService!.new_object_address =
                                addressController.text;
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LinkPUStep2(
                                        crrentPu: selectedObject!,
                                      )));
                        }
                      : null,
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

  @override
  void didChangeDependencies() {
    linkPuService ??= DependencyProvider.of(context)!.linkPuService;
    super.didChangeDependencies();
  }
}
