import 'dart:convert';

import 'package:conres_app/Services/update-tu-service.dart';
import 'package:conres_app/model/TU.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:conres_app/profile/main-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../UI/main-form.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/TU/TU-element.dart';
import '../elements/TU/edit-tu-dialog.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header-notification.dart';
import '../elements/not-found.dart';
import '../elements/testimony/object-pu-dialog.dart';
import '../websocket/message-send.dart';
import 'link-pu/link-pu-step-1.dart';
import 'link-tu/link-tu.dart';

class PageTU extends StatefulWidget {
  ObjectPuModel currentPU;

  PageTU({required this.currentPU});
  @override
  State<StatefulWidget> createState() => _PageTU();
}

class _PageTU extends State<PageTU> {
  ProfileBloc? profileBloc;
  List<TuModel> objects = []; // ТУ
  Map<String, dynamic> objectsTuMap = {};
  Widget body = Container();
  ScrollController scrollController = ScrollController();
  WebSocketChannel? webSocketChannel;
  UpdateTuService? updateTuService;

  bool isLoaded = false;
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
              onRefrash: _refrash,
              header: HeaderNotification(canGoBack: true, text: "Точки учета"),
              body: Stack(
              children: [
                ListView.builder(
                  itemCount: objectsTuMap.length,
                  itemBuilder: (context, int index) {
                    return TuElement(currentTu: objectsTuMap.values.elementAt(index), remove: removeTu);
                  }),
                Visibility(
                  visible: objectsTuMap.isEmpty && isLoading == false ? true : false,
                  child: NotFound(
                    title: "Точки учета",
                    text: "По данному объекту не найдены точки учета."),
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
              footer: Container(
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                          left: defaultSidePadding,
                        ),
                        width: 160,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LinkTu(currentPU: widget.currentPU, refrash: _refrash)));
                          },
                          child: const Text("Новый ТУ",
                              style: TextStyle(fontSize: 18)),
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
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorMain,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ))
                  ],
                ),
              ));
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    } else {
      isLoading = false;
    }
    if (state.TuPoints != null && isLoaded == false) {
      objectsTuMap = {for (var e in state.TuPoints!) e.point_id!: e};
      isLoaded = true;
    }
  }

  void updateStatus(String id, String status, String? comment) {
    TuModel newTu = objectsTuMap[id];
    newTu.status = status;
    if (comment != null) {
      newTu.comments = comment;
    }
    setState(() {
      objectsTuMap.update(id, (value) => newTu);
    });
  }

  void removeTu(TuModel tuModel) {
    profileBloc!.hiddenTU(tuModel.point_id!);
    dynamic message = MessageSend(
                    cmd: "publish",
                    subject: "store-${store_id}",
                    event: "point_binding_delete",
                    data: TuHidden(point_id: int.parse(tuModel.point_id!)),
                    to_id: int.parse(user_id!)
                  );
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
    setState(() {
      objectsTuMap.remove(tuModel.point_id);
    });
  }

  Future<void> _refrash() async {
    isLoaded = false;
    profileBloc!.getTuPoints();
  }

  void _edit() {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            EditTuDialog(title: "Редактировать ТУ"));
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    updateTuService ??= DependencyProvider.of(context)!.updateTuService;
    updateTuService!.update = updateStatus;
    webSocketChannel ??=
        DependencyProvider.of(context)!.webSocketChannel(false);
    profileBloc!.getTuPoints();
    super.didChangeDependencies();
  }
}
