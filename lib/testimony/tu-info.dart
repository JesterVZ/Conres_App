import 'dart:convert';

import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Services/update-meter-service.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/not-found.dart';
import '../elements/testimony/meter.dart';
import '../model/TU.dart';
import '../model/meter.dart';
import '../websocket/message-send.dart';

class TuFullInfo extends StatefulWidget {
  List<TuModel> TuPoints;
  final TuModel? currentTu;
  TuFullInfo({required this.currentTu, required this.TuPoints});
  @override
  State<StatefulWidget> createState() => _TuFullInfo();
}

class _TuFullInfo extends State<TuFullInfo> {
  ProfileBloc? profileBloc;
  ProfileService? profileService;
  WebSocketChannel? webSocketChannel;
  UpdateMeterService? updateMeterService;
  Map<String, dynamic> objectsMap = {};
  ScrollController scrollController = ScrollController();

  bool isLoaded = false;
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
            header:
                HeaderNotification(text: "Информация о ПУ", canGoBack: true),
            body: Stack(
              children: [
                ListView.builder(
                    itemCount: objectsMap.length,
                    itemBuilder: (context, int index) {
                      return MeterElement(
                          currentMeter: objectsMap.values.elementAt(index),
                          currentTu: widget.currentTu,
                          remove: removeMeter,
                          refrash: _refrash,
                          edit: editMeter,
                          TuPoints: widget.TuPoints);
                    }),
                Visibility(
                  visible:
                      objectsMap.isEmpty && isLoading == false ? true : false,
                  child: NotFound(
                      title: "Счетчики",
                      text:
                          "По данной точке учета счетчики не найдены, либо ожидают подтверждения."),
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
            onRefrash: _refrash,
          );
        });
  }

  void removeMeter(Meter meter) {
    profileBloc!.hiddenMeter(meter.meter_id!);
    dynamic message = MessageSend(
        cmd: "publish",
        subject: "store-${store_id}",
        event: "meter_binding_delete",
        data: MeterHidden(meter_id: int.parse(meter.meter_id!)),
        to_id: int.parse(user_id!));
    String data = jsonEncode(message.toJson());
    webSocketChannel!.sink.add(data);
    setState(() {
      objectsMap.remove(meter.meter_id);
    });
  }

  void editMeter(Meter meter) {}

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    } else {
      isLoading = false;
    }
    if (state.TuMeters != null && isLoaded == false) {
      objectsMap = {for (var e in state.TuMeters!) e.meter_id!: e};
      isLoaded = true;
    }
  }

  Future<void> _refrash() async {
    isLoaded = false;
    profileBloc!.getMetersFromTU(widget.currentTu!.point_id!, profileService!.object_id!);
  }

  void updateStatus(String id, String status, String? comment) {
    Meter newMeter = objectsMap[id];
    newMeter.status = status;
    if (comment != null) {
      newMeter.comments = comment;
    }
    setState(() {
      objectsMap.update(id, (value) => newMeter);
    });
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
    webSocketChannel ??=
        DependencyProvider.of(context)!.webSocketChannel(false);
    updateMeterService ??= DependencyProvider.of(context)!.updateMeterService;
    updateMeterService!.update = updateStatus;
    profileBloc!.getMetersFromTU(widget.currentTu!.point_id!, profileService!.object_id!);
    super.didChangeDependencies();
  }
}
