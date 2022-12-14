import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/Services/update-object-service.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../Services/bottom-navigation-select-service.dart';
import '../UI/default-button.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/not-found.dart';
import '../elements/testimony/object-pu-dialog.dart';
import '../elements/testimony/object-pu.dart';
import '../profile/tab-item.dart';
import '../websocket/message-send.dart';
import 'link-pu/link-pu-step-1.dart';
import 'new-object/new-object.dart';

class ObjectsPU extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ObjectsPU();
}

class _ObjectsPU extends State<ObjectsPU> {
  Future<void> _refrash() async {
    isLoaded = false;
    profileBloc!.getObjectsPU();
  }

  ProfileBloc? profileBloc;
  ProfileService? profileService;
  BottomNavigationSelectService? bottomNavigationSelectService;
  Map<String, dynamic> objectsMap = {};
  ScrollController scrollController = ScrollController();
  UpdateObjectService? updateObjectService;
  WebSocketChannel? webSocketChannel;

  bool isLoaded = false;
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    double bottomButtonWidth = (MediaQuery.of(context).size.width/2)-5;
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
              header: HeaderNotification(
                text: "Ваши объекты",
                canGoBack: true,
              ),
              body: Stack(
                children: [
                  ListView.builder(
                      itemCount: objectsMap.length,
                      itemBuilder: (context, int index) {
                        return ObjectPU(
                            objectPuModel: objectsMap.values.elementAt(index),
                            remove: removeObject,
                            refrash: _refrash,
                            edit: editObject);
                      }),
                  Visibility(
                      visible: objectsMap.isEmpty && isLoading == false
                          ? true
                          : false,
                      child: NotFound(
                          title: profileService!.accountNumber == ""
                              ? "Заключите договор"
                              : objectsMap.isEmpty
                                  ? "Приборы учета"
                                  : "",
                          text: profileService!.accountNumber == ""
                              ? "У вас нет активного Лицевого cчёта, отправьте запрос на привязку лицевого счета (договора) и дождитесь его подтверждения!"
                              : objectsMap.isEmpty
                                  ? "По данному лицевому счёту не найдены приборы учёта, отправьте заявку на привязку ПУ и дождитесь подтверждения."
                                  : "")),
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
              footer: profileService!.accountNumber == ""
                  ? DefaultButton(
                      isGetPadding: true,
                      onPressed: () {
                        bottomNavigationSelectService!.canLogin = false;
                        bottomNavigationSelectService!.function!
                            .call(TabItem.contracts);
                      },
                      text: "Отправить запрос")
                  : Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                              left: defaultSidePadding,
                            ),
                            width: bottomButtonWidth,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewObject(
                                              refrash: _refrash,
                                            )));
                              },
                              child: Text("Новый объект",
                                  style: TextStyle(fontSize: bottomButtonWidth * 0.1)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorMain,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                            )),
                        const Spacer(),
                        Container(
                            padding: EdgeInsets.only(right: defaultSidePadding),
                            width:  bottomButtonWidth,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LinkPUStep1()));
                              },
                              child: Text("Новый ПУ",
                                  style: TextStyle(fontSize: bottomButtonWidth * 0.1)),
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
    if (state.objectsPU != null && isLoaded == false) {
      objectsMap = {for (var e in state.objectsPU!) e.object_id!: e};
      objectsList = state.objectsPU;
      isLoaded = true;
    }
    if (state.editObjectData != null) {
      dynamic message = MessageSend(
          cmd: "publish",
          subject: "store-${store_id}",
          event: "object_binding_edit_new",
          data: ObjectEdited(
            objectId: state.editObjectData!['object_id'],
            newObjectName: state.editObjectData!['new_object_name'],
            newObjectAddress: state.editObjectData!['new_object_address'],
            accountId: state.editObjectData!['account_id'],
            accountNumber: state.editObjectData!['account_number'],
            userLkId: state.editObjectData!['user_lk_id'],
            dateAdded: state.editObjectData!['date_added'],
            edit: state.editObjectData!['edit'],
            approve: state.editObjectData!['approve'],
            requestId: state.editObjectData!['request_id'],
            objectAddress: state.editObjectData!['object_address'],
            objectName: state.editObjectData!['object_name'],
          ),
          to_id: int.parse(user_id!));
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
      _refrash();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Данные объекта успешно изменены!",
        btnOkOnPress: () {},
      ).show();
    }
  }

  void updateStatus(String id, String status, String? comment) {
    ObjectPuModel newContract = objectsMap[id];
    newContract.status = status;
    if (comment != null) {
      newContract.comments = comment;
    }
    setState(() {
      objectsMap.update(id, (value) => newContract);
    });
  }

  void editObject(ObjectPuModel object) {
    profileBloc!.editObject(object.object_id!, object.name!, object.address!);
  }

  void removeObject(ObjectPuModel objectPuModel) {
    profileBloc!.hiddenObject(objectPuModel.object_id!);
    dynamic message = MessageSend(
        cmd: "publish",
        subject: "store-${store_id}",
        event: "object_binding_delete",
        data: ObjectHidden(object_id: int.parse(objectPuModel.object_id!)),
        to_id: int.parse(user_id!));
    String data = jsonEncode(message.toJson());
    webSocketChannel!.sink.add(data);
    setState(() {
      objectsMap.remove(objectPuModel.object_id);
    });
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
    bottomNavigationSelectService ??=
        DependencyProvider.of(context)!.bottomNavigationSelectService;
    updateObjectService ??= DependencyProvider.of(context)!.updateObjectService;
    webSocketChannel ??=
        DependencyProvider.of(context)!.webSocketChannel(false);
    updateObjectService!.update = updateStatus;
    profileBloc!.getObjectsPU();
    super.didChangeDependencies();
  }
}
