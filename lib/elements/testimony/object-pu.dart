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
import 'object-pu-dialog.dart';

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
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
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
                            : (widget.objectPuModel.status == "1" || widget.objectPuModel.status == "3")
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
                          : 
                               "Проходит проверку на изменение",
                      style: TextStyle(color: Colors.white, fontSize: 14),
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
                  Container(
                    height: 50,
                    width: 142,
                    child: ElevatedButton(
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
                              padding: EdgeInsets.only(left: defaultSidePadding, top: 5, right: defaultSidePadding),
                              height: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Form(
                                key: _formKey,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: const Text("Редактировать объект", style: TextStyle(fontSize: 20)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: DefaultInput(
                                  labelText: "Наименование объекта", 
                                  keyboardType: TextInputType.text,
                                  hintText: "Дом",
                                  validatorText: "Введите наименование",
                                  controller: nameController),
                                ),
                                

                                DefaultInput(
                                  labelText: "Адрес объекта", 
                                  keyboardType: TextInputType.text,
                                  hintText: "Город, Улица, Дом, Квартира",
                                  validatorText: "Введите адрес",
                                  controller: addressController),
                              ]),
                            
                              )
                              
                            ),
                          ).show();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: messageColor),
                        child: Text("Редактировать",
                            style: TextStyle(color: colorMain))),
                  ),
                  const Spacer(),
                  Container(
                    height: 50,
                    width: 142,
                    child: ElevatedButton(
                        onPressed: () {
                          profileService!.object_id = widget.objectPuModel.object_id;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageTU(
                                        currentPU: widget.objectPuModel,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: messageColor),
                        child: Text("Подробнее",
                            style: TextStyle(color: colorMain))),
                  ),
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
