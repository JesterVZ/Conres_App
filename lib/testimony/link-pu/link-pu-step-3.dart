import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/elements/dropdown.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../UI/default-button.dart';
import '../../UI/main-form.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../../elements/PU/list-element.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../../elements/header/header-notification.dart';
import '../../elements/testimony/select-object-doalog.dart';

class LinkPUStep3 extends StatefulWidget {
  const LinkPUStep3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkPUStep3();
}

class _LinkPUStep3 extends State<LinkPUStep3> {
  ProfileBloc? profileBloc;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController tariffController = TextEditingController();
  TextEditingController multipler = TextEditingController();

  bool? isLoading;

  List dropdownTypeList = [
    {'label': 'Электроэнергия', 'value': '1'}
  ];
  List dropdownTariffList = [
    {'label': 'Двухтарифный', 'value': '2'},
    {'label': 'Однотарифный', 'value': '3'}
  ];

  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
              header: HeaderNotification(text: "Привязать ПУ", canGoBack: true),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: defaultSidePadding,
                            right: defaultSidePadding),
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
                                margin: EdgeInsets.only(bottom: 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Тип ПУ", style: labelTextStyle),
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CoolDropdown(
                                            resultHeight: 55,
                                            resultTS: TextStyle(
                                              fontSize: 20,
                                              color: colorMain,
                                            ),
                                            resultBD: BoxDecoration(
                                              color: messageColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            selectedItemBD: BoxDecoration(
                                              color: messageColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            selectedItemTS: TextStyle(
                                              fontSize: 20,
                                              color: colorMain,
                                            ),
                                            dropdownBD: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                            255, 49, 49, 49)
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 1),
                                                  ),
                                                ]),
                                            dropdownWidth:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    50,
                                            dropdownHeight: 100,
                                            resultWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            dropdownList: dropdownTypeList,
                                            onChange: (_) {},
                                            defaultValue: dropdownTypeList[0],
                                          )),
                                    ])),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Тип ПУ", style: labelTextStyle),
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CoolDropdown(
                                            resultHeight: 55,
                                            resultTS: TextStyle(
                                              fontSize: 20,
                                              color: colorMain,
                                            ),
                                            resultBD: BoxDecoration(
                                              color: messageColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            selectedItemBD: BoxDecoration(
                                              color: messageColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            selectedItemTS: TextStyle(
                                              fontSize: 20,
                                              color: colorMain,
                                            ),
                                            dropdownBD: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                            255, 49, 49, 49)
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 1),
                                                  ),
                                                ]),
                                            dropdownWidth:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    50,
                                            dropdownHeight: 150,
                                            resultWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            dropdownList: dropdownTariffList,
                                            onChange: (_) {},
                                            defaultValue: dropdownTariffList[0],
                                          )),
                                    ])),
                            DefaultInput(
                                labelText: "Множитель показаний",
                                keyboardType: TextInputType.text,
                                hintText: "Множитель показаний",
                                controller: multipler),
                          ],
                        )),
                  ),
                  Visibility(
                      child: Center(
                          child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(color: colorMain),
                      )),
                      visible: (isLoading == true) ? true : false)
                ],
              ),
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
                        child: const Text("Отправить",
                            style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ))
                ],
              ),
              onRefrash: _refrash);
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    } else {
      isLoading = false;
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    super.didChangeDependencies();
  }
}
