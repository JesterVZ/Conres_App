import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/not-found.dart';
import '../elements/testimony/meter.dart';
import '../model/TU.dart';
import '../model/meter.dart';

class TuFullInfo extends StatefulWidget {
  List<TuModel> TuPoints;
  final TuModel? currentTu;
  TuFullInfo({required this.currentTu, required this.TuPoints});
  @override
  State<StatefulWidget> createState() => _TuFullInfo();
}

class _TuFullInfo extends State<TuFullInfo> {
  ProfileBloc? profileBloc;
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
                          remove: removeObject,
                          edit: editMeter,
                          TuPoints: widget.TuPoints);
                    }),
                Visibility(
                  visible:
                      objectsMap.isEmpty && isLoading == false ? true : false,
                  child: NotFound(
                      title: "Счетчики",
                      text: "По данной точке учета не найдены счетчики."),
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

  void removeObject(Meter meter) {}

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
    profileBloc!.getMetersFromTU(widget.currentTu!.point_id!);
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getMetersFromTU(widget.currentTu!.point_id!);
    super.didChangeDependencies();
  }
}
