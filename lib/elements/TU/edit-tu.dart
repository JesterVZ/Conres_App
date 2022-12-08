import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/TU.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';

import '../../DI/dependency-provider.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../bloc/bloc-screen.dart';
import '../dropdown.dart';

class EditPuPage extends StatefulWidget {
  List<TuModel> TuPoints;
  EditPuPage({required this.TuPoints});
  @override
  State<StatefulWidget> createState() => _EditPuPage();
}

class _EditPuPage extends State<EditPuPage> {
  TextEditingController objectController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  ProfileBloc? profileBloc;

  List<Widget> tu = [];
  List<String> points = [""];
  List dropdownItemList = [];
  bool isLoaded = false;
  final _formKey = GlobalKey<FormState>();
  Future<void> _refrash() async {}

  void select(String value) {}

  @override
  void initState() {
    for (int i = 0; i < widget.TuPoints.length; i++) {
      dropdownItemList.add(
          {'label': widget.TuPoints[i].name, 'value': widget.TuPoints[i].name});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocScreen<ProfileBloc, ProfileState>(
            bloc: profileBloc,
            listener: (context, state) => _listener(context, state),
            builder: (context, state) {
              return MainForm(
                  header: HeaderNotification(
                      text: "Редактировать ПУ", canGoBack: true),
                  body: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: defaultSidePadding,
                              right: defaultSidePadding),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Точка учёта", style: labelTextStyle),
                                  Container(
                                    child: CoolDropdown(
                                      dropdownWidth:
                                          MediaQuery.of(context).size.width -
                                              50,
                                      resultWidth:
                                          MediaQuery.of(context).size.width,
                                      dropdownList: dropdownItemList,
                                      onChange: (_) {},
                                      defaultValue: dropdownItemList[0],
                                      // placeholder: 'insert...',
                                    ),
                                  ),
                                  Column(children: tu),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: DefaultButton(
                                        text: "Добавить новую ТУ",
                                        onPressed: () {},
                                        isGetPadding: false),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: DefaultInput(
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        labelText: "Наименование ПУ",
                                        hintText: "Наименование ПУ",
                                        validatorText:
                                            "Введите наименование ПУ"),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: DefaultInput(
                                        controller: numberController,
                                        keyboardType: TextInputType.text,
                                        labelText: "Номер ПУ",
                                        hintText: "Номер ПУ",
                                        validatorText: "Введите номер ПУ"),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Тип ПУ",
                                                style: labelTextStyle),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                  child: CoolDropdown(
                                                    dropdownWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            50,
                                                    resultWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    dropdownList:
                                                        dropdownItemList,
                                                    onChange: (_) {},
                                                    defaultValue:
                                                        dropdownItemList[0],
                                                    // placeholder: 'insert...',
                                                  ),
                                                )),
                                          ])),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Тарифная зона",
                                                style: labelTextStyle),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                  child: CoolDropdown(
                                                    dropdownWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            50,
                                                    resultWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    dropdownList:
                                                        dropdownItemList,
                                                    onChange: (_) {},
                                                    defaultValue:
                                                        dropdownItemList[0],
                                                    // placeholder: 'insert...',
                                                  ),
                                                )),
                                          ])),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: DefaultInput(
                                        controller: numberController,
                                        keyboardType: TextInputType.text,
                                        labelText: "Номер ПУ",
                                        hintText: "Номер ПУ",
                                        validatorText: "Введите номер ПУ"),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: DefaultButton(
                                        text: "Сохранить",
                                        onPressed: () {},
                                        isGetPadding: false),
                                  ),
                                ],
                              )))),
                  onRefrash: _refrash);
            }));
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.TuPoints != null && isLoaded == false) {
      for (int i = 0; i < state.TuPoints!.length; i++) {
        points.add(state.TuPoints![i].name!);

        //dropdownItemList.removeAt(0);
      }
      isLoaded = true;
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;

    super.didChangeDependencies();
  }
}
