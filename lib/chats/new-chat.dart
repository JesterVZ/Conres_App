import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  ProfileBloc? profileBloc;
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
              return Scaffold(
            body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: defaultSidePadding, right: defaultSidePadding),
                      height: 100,
                      child: HeaderNotification(
                        text: "Новое обращение",
                      )),
                  Form(
                    child: Column(
                      children: [
                         CustomDropDown(title: "Тема обращения", items: [
                          "Вопрос о техническом присоединении",
                          "Сообшение об аварии",
                          "Другое"
                        ]),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ФИО",
                                    style: TextStyle(
                                        color: colorGray, fontSize: 16.0)),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Введите ФИО";
                                    }
                                    return null;
                                  },
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: FioController,
                                  decoration: InputDecoration(
                                      hintText: "Иван",
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: inputBorder))),
                                )
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email",
                                    style: TextStyle(
                                        color: colorGray, fontSize: 16.0)),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Введите email";
                                    }
                                    return null;
                                  },
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: EmailController,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: inputBorder))),
                                )
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Текст обращения",
                                    style: TextStyle(
                                        color: colorGray, fontSize: 16.0)),
                                TextFormField(
                                  maxLines: 6,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Введите текст";
                                    }
                                    return null;
                                  },
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: TextController,
                                  decoration: InputDecoration(
                                      hintText: "Текст",
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: inputBorder))),
                                )
                              ],
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: (){
                              profileBloc?.createNewTicket(EmailController.text, FioController.text, "ticket_theme_id", TextController.text);
                            },
                            child: const Text("Добавить новое обращение", style: TextStyle(fontSize: 18),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorMain
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ])
              ],
            ),
          ),
        ));
            }
        )
  );
  }
  _listener(BuildContext context, ProfileState state) {
    if(state.loading == true){
      return;
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    super.didChangeDependencies();
  }
}
