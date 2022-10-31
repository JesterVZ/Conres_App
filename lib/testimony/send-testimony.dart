import 'dart:core';

import 'package:conres_app/Services/send-testimont-service.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/elements/testimony/testimony-not-found.dart';
import 'package:conres_app/testimony/link-pu.dart';
import 'package:conres_app/testimony/objects-pu.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/alert.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header-notification.dart';
import '../elements/testimony/testimony.dart';

class SendTestimony extends StatefulWidget {
  final String? personal;

  const SendTestimony({required this.personal});

  @override
  State<StatefulWidget> createState() => _SendTestimony();
}

class _SendTestimony extends State<SendTestimony> {
  ProfileBloc? profileBloc;
  bool getPU = false;
  bool isLoading = true;
  List<Widget> meters = [];
  SendTestimonyService? sendTestimonyService;

  List<TextEditingController>? dayControllers = [];
  List<TextEditingController>? nightControllers = [];

  Future<void> _refrash() async {}

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Stack(
            children: [
              MainForm(
                  header: HeaderNotification(
                      text: "Передача показаний", canGoBack: true),
                  body: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: defaultSidePadding,
                              right: defaultSidePadding),
                          child: Column(
                            children: meters,
                          ))),
                  footer: DefaultButton(
                      isGetPadding: true,
                      onPressed: () {
                        List<String> dayValues = [];
                        List<String> nightValues = [];
                        for (int i = 0; i < dayControllers!.length; i++) {
                          dayValues.add(dayControllers![i].text);
                        }
                        for (int i = 0; i < nightControllers!.length; i++) {
                          nightValues.add(nightControllers![i].text);
                        }
                        profileBloc!.sendTestimony(dayValues, nightValues);
                      },
                      text: "Передать показания"),
                  onRefrash: _refrash),
              Visibility(
                  child: Center(
                      child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(color: colorMain),
                  )),
                  visible: (isLoading == true) ? true : false)
            ],
          );
        });
  }

  void addMeasure() {}
  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading!;
    if (state.loading!) {
      return;
    }
    if (state.meters != null) {
      getPU = true;
      for (int i = 0; i < state.meters!.length; i++) {
        dayControllers!.add(TextEditingController());
        nightControllers!.add(TextEditingController());
        meters.add(Testimony(
            meter: state.meters![i],
            dayController: dayControllers![i],
            nightController: nightControllers![i]));
      }
    }
    if (state.loading! == false && state.isMeasureSent == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Успешно!", text: "Показания переданы!"));
    }
    if (state.error != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Ошибка!", text: state.error.toString()));
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    sendTestimonyService ??=
        DependencyProvider.of(context)!.sendTestimonyService;
    profileBloc!.getTU();
    super.didChangeDependencies();
  }
}
