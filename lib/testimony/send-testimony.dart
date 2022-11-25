import 'dart:core';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/Services/send-testimont-service.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/elements/testimony/testimony-not-found.dart';
import 'package:conres_app/model/meter.dart';
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
  List<Meter> meters = [];
  SendTestimonyService? sendTestimonyService;
  ScrollController scrollController = ScrollController();

  List<TextEditingController>? dayControllers = [];
  List<TextEditingController>? nightControllers = [];

  Widget? body = Container();
  Widget? footer = Container();

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
                  body: body!,
                  footer: footer,
                  onRefrash: _refrash),
              Visibility(
                  child: Center(
                      child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(color: colorMain),
                  )),
                  visible: (isLoading == true) ? true : false),
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
      meters = state.meters!;
      if (state.meters!.isEmpty) {
        body = Padding(
            padding: EdgeInsets.only(
                left: defaultSidePadding, right: defaultSidePadding),
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              height: 175,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Приборы учёта",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      SvgPicture.asset('assets/search.svg')
                    ],
                  ),
                  Text(
                    "По данному лицевому счёту не найдены приборы учёта, отправьте заявку на привязку ПУ и дождитесь подтверждения.",
                    style: TextStyle(color: colorGrayClaim, fontSize: 16),
                  )
                ],
              ),
            ));
        footer = DefaultButton(
            isGetPadding: true,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ObjectsPU()));
            },
            text: "Привязать новый ПУ");
      } else {
        body = ListView.builder(
            controller: scrollController,
            itemCount: meters.length,
            itemBuilder: (context, int index) {
              return Testimony(
                  meter: meters[index],
                  dayController: dayControllers![index],
                  nightController: nightControllers![index]);
            });
        footer = DefaultButton(
            isGetPadding: true,
            onPressed: () {
              List<String> dayValues = [];
              List<String> nightValues = [];
              bool isEmpty = true;
              for (int i = 0; i < dayControllers!.length; i++) {
                if (dayControllers![i].text != "") {
                  isEmpty = false;
                }
                dayValues.add(dayControllers![i].text);
              }
              for (int i = 0; i < nightControllers!.length; i++) {
                if (nightControllers![i].text != "") {
                  isEmpty = false;
                }
                nightValues.add(nightControllers![i].text);
              }
              if (isEmpty == false) {
                profileBloc!.sendTestimony(dayValues, nightValues);
              } else {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.bottomSlide,
                  headerAnimationLoop: false,
                  title: "Внимание!",
                  desc: "Введите показания!",
                  btnOkColor: Colors.blue,
                  btnOkOnPress: () {},
                ).show();
              }
            },
            text: "Передать показания");
      }
      for (int i = 0; i < state.meters!.length; i++) {
        dayControllers!.add(TextEditingController());
        nightControllers!.add(TextEditingController());
      }
    }
    if (state.loading! == false && state.isMeasureSent == true) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Показания переданы!",
        btnOkOnPress: () {},
      ).show();
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
