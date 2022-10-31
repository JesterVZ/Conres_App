import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UI/default-input.dart';
import '../UI/main-form.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/dropdown.dart';
import '../elements/header/header-notification.dart';

class NewChat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewChat();
}

class _NewChat extends State<NewChat> {
  TextEditingController FioController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController TextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ProfileBloc? profileBloc;
  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            onRefrash: _refrash,
            header: HeaderRow(text: "Новое обращение", fontSize: 24),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: const CustomDropDown(
                                title: "Выберите причину",
                                items: [
                                  "вопрос о техническом присоединении",
                                  "сообщить об аварии",
                                  "другое"
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: DefaultInput(
                                  controller: FioController,
                                  keyboardType: TextInputType.text,
                                  labelText: "ФИО",
                                  hintText: "Иванов Иван Иванович",
                                  validatorText: "Введите ФИО")),
                          Container(
                            margin: EdgeInsets.only(bottom: 12),
                            child: DefaultInput(
                                controller: EmailController,
                                keyboardType: TextInputType.text,
                                labelText: "Email",
                                hintText: "Example@gmail.com",
                                validatorText: "Введите Email"),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Текст обращения",
                                      style: TextStyle(
                                          color: colorGray, fontSize: 16.0)),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Введите текст";
                                      }
                                      return null;
                                    },
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    maxLines: 5,
                                    controller: TextController,
                                    decoration: InputDecoration(
                                        hintText: "Текст Вашего обращения",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: inputBorder, width: 5.0),
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  )
                                ],
                              )),
                          DefaultButton(
                              text: "Создать обращение",
                              isGetPadding: false,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  profileBloc!.createNewTicket(
                                      EmailController.text,
                                      FioController.text,
                                      "0",
                                      TextController.text);
                                  Navigator.pop(context);
                                }
                              })
                        ],
                      ),
                    )))));
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;

    super.didChangeDependencies();
  }
}
