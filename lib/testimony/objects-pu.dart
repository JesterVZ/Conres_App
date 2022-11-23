import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../DI/dependency-provider.dart';
import '../UI/default-button.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/testimony/object-pu-dialog.dart';
import '../elements/testimony/object-pu.dart';
import 'link-pu/link-pu-step-1.dart';

class ObjectsPU extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ObjectsPU();
}

class _ObjectsPU extends State<ObjectsPU> {
  Future<void> _refrash() async {}
  ProfileBloc? profileBloc;
  List<ObjectPuModel> objects = [];
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
              header: HeaderNotification(
                text: "Ваши объекты",
                canGoBack: true,
              ),
              body: ListView.builder(
                      controller: scrollController,
                      itemCount: objects.length,
                      itemBuilder: (context, int index) {
                        return ObjectPU(objectPuModel: objects[index]);
                      }),
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

                          AwesomeDialog(
                              context: context,
                              animType: AnimType.bottomSlide,
                              dialogType: DialogType.noHeader,
                              body: Container(
                                padding: EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding, bottom: 17),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(children: [
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 18),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Номер ТУ",
                                              style: TextStyle(
                                                  color: colorGray,
                                                  fontSize: 16.0)),
                                          TextField(
                                            decoration: InputDecoration(
                                                hintText: "Номер ТУ",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: inputBorder))),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 18),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Наименование ТУ",
                                              style: TextStyle(
                                                  color: colorGray,
                                                  fontSize: 16.0)),
                                          TextField(
                                            decoration: InputDecoration(
                                                hintText: "Наименование",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: inputBorder))),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 18),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Адрес ТУ",
                                              style: TextStyle(
                                                  color: colorGray,
                                                  fontSize: 16.0)),
                                          TextField(
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Город, Улица, Дом, Квартира",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: inputBorder))),
                                          )
                                        ],
                                      )),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55,
                                      child: DefaultButton(
                                        isGetPadding: false,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          //profileBloc!.editTu(id, number, name, address);
                                        },
                                        text: "Принять",
                                      ))
                                ]),
                              )).show();
                        },
                        child: const Text("Новый объект",
                            style: TextStyle(fontSize: 14)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      )),
                  const Spacer(),
                  Container(
                      padding: EdgeInsets.only(right: defaultSidePadding),
                      width: 160,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LinkPUStep1()));
                        },
                        child: const Text("Новый ПУ",
                            style: TextStyle(fontSize: 14)),
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
      return;
    }
    if (state.objectsPU != null) {
      objects = state.objectsPU!;
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getObjectsPU();
    super.didChangeDependencies();
  }
}
