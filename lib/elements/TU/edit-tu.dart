import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';

import '../../consts.dart';
import '../dropdown.dart';

class EditPuPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _EditPuPage();
}

class _EditPuPage extends State<EditPuPage>{

  TextEditingController objectController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  List<Widget> tu = [];
  final _formKey = GlobalKey<FormState>();
  Future<void> _refrash() async {}

  void select(String value){
    
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
      header: HeaderNotification(text: "Редактировать ПУ", canGoBack: true), 
      body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                      key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Точка учёта", style: labelTextStyle),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                                      width: MediaQuery.of(context).size.width,
                                      child: CustomDropDown(
                                        selectedItem: objectController,
                                        onClick: select,
                                        title: "Выберите точку учета",
                                        items: const [
                                          "увеличением объема максимальной мощности",
                                          "новым строительством",
                                          "изменением категории надежности электроснабжения",
                                          "другое"
                                        ],
                                      )),
                            Column(children: tu),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: DefaultButton(
                              text: "Добавить новую ТУ", 
                              onPressed: (){}, 
                              isGetPadding: false),
                            ),
                            
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: DefaultInput(controller: nameController, keyboardType: TextInputType.text, labelText: "Наименование ПУ", hintText: "Наименование ПУ", validatorText: "Введите наименование ПУ"),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: DefaultInput(controller: numberController, keyboardType: TextInputType.text, labelText: "Номер ПУ", hintText: "Номер ПУ", validatorText: "Введите номер ПУ"),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text("Тип ПУ", style: labelTextStyle),
                                Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: CustomDropDown(
                                        selectedItem: objectController,
                                        title: "Выберите тип",
                                        items: const [
                                          "Электроэнергия"
                                        ],
                                      )),
                              ])
                              
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text("Тарифная зона", style: labelTextStyle),
                                Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: CustomDropDown(
                                        selectedItem: objectController,
                                        title: "Выберите зону",
                                        items: const [
                                          "Двухтарифный"
                                        ],
                                      )),
                              ])
                              
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: DefaultInput(controller: numberController, keyboardType: TextInputType.text, labelText: "Номер ПУ", hintText: "Номер ПУ", validatorText: "Введите номер ПУ"),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: DefaultButton(
                              text: "Сохранить", 
                              onPressed: (){}, 
                              isGetPadding: false),
                            ),
                          ],
                        )
                    ))), 
      onRefrash: _refrash)
 );
     
  }
}