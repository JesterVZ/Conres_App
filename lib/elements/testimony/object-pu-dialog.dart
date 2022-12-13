import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/model/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../alert.dart';
import '../bloc/bloc-screen.dart';

class ObjectPuDialog extends StatefulWidget {
  String? title;
  String? id;
  ObjectPuDialog({required this.title, required this.id});
  @override
  State<StatefulWidget> createState() => _ObjectPuDialog();
}

class _ObjectPuDialog extends State<ObjectPuDialog> {
  double? value;
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  ProfileBloc? profileBloc;
  bool isSent = false;
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return AlertDialog(
              title: Text(widget.title!),
              content: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                  height: 280,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Column(children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Наименование объекта",
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: name,
                              decoration: InputDecoration(
                                  hintText: "Дом",
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
                            Text("Адрес объекта",
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: address,
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
                            isSent = true;
                            profileBloc!.editObject(
                                widget.id!, name.text, address.text);

                            //Navigator.pop(context);
                          },
                          text: "Принять",
                        ))
                  ]),
                ),
              
              ));
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.loading == false && state.error == null && isSent == true) {
      isSent = false;
      Navigator.pop(context);
    } else if (state.loading == false && state.error != null) {
      
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Ошибка!", text: "Ошибка редактирования!"));
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    super.didChangeDependencies();
  }
}
