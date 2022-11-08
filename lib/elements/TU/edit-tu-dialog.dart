import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../UI/default-button.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../bloc/bloc-screen.dart';

class EditTuDialog extends StatefulWidget {
  String? title;
  EditTuDialog({required this.title});
  @override
  State<StatefulWidget> createState() => _EditTuDialog();
}

class _EditTuDialog extends State<EditTuDialog> {
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ProfileBloc? profileBloc;
  bool isSent = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.title!),
        content: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: BlocScreen<ProfileBloc, ProfileState>(
                bloc: profileBloc,
                listener: (context, state) => _listener(context, state),
                builder: (context, state) {
                  return Container(
                    height: 350,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Column(children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Номер ТУ",
                                  style: TextStyle(
                                      color: colorGray, fontSize: 16.0)),
                              TextField(
                                controller: numberController,
                                decoration: InputDecoration(
                                    hintText: "Номер ТУ",
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
                              Text("Наименование ТУ",
                                  style: TextStyle(
                                      color: colorGray, fontSize: 16.0)),
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: "Наименование",
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
                              Text("Адрес ТУ",
                                  style: TextStyle(
                                      color: colorGray, fontSize: 16.0)),
                              TextField(
                                controller: addressController,
                                decoration: InputDecoration(
                                    hintText: "Город, Улица, Дом, Квартира",
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: inputBorder))),
                              )
                            ],
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: DefaultButton(
                            isGetPadding: false,
                            onPressed: () {
                              //profileBloc!.editTu(id, number, name, address);
                            },
                            text: "Принять",
                          ))
                    ]),
                  );
                })));
  
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.loading == false && state.error == null && isSent == true) {}
  }
}
