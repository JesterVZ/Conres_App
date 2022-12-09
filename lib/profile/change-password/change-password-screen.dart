import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../DI/dependency-provider.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../../elements/alert.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../../elements/masks.dart';
import '../../websocket/message-send.dart';
import 'package:intl/intl.dart';

class ChangePasswordScreen extends StatefulWidget {
  VoidCallback? refrash;
  ChangePasswordScreen({Key? key, required this.refrash}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  ProfileBloc? profileBloc;
  TextEditingController lsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  WebSocketChannel? webSocketChannel;
  final _formKey = GlobalKey<FormState>();

  Future<void> _refrash() async {}

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
            header:
                HeaderNotification(text: "Изменить пароль", canGoBack: true),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 25),
                              child: DefaultInput(
                                  labelText: "Текущий пароль",
                                  hintText: "Город, Улица, Дом, Квартира",
                                  validatorText: "Введите адрес объекта",
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  controller: addressController)),
                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: DefaultInput(
                                  labelText: "Пароль",
                                  hintText: "Город, Улица, Дом, Квартира",
                                  validatorText: "Введите адрес объекта",
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  controller: addressController)),
                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: DefaultInput(
                                  labelText: "Пароль",
                                  hintText: "Город, Улица, Дом, Квартира",
                                  validatorText: "Введите адрес объекта",
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  controller: addressController))
                        ],
                      ),
                    ))),
            footer: DefaultButton(
              text: "Отправить запрос на привязку",
              isGetPadding: true,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  profileBloc!
                      .bindNewLS(lsController.text, addressController.text);
                }
              },
            ),
            onRefrash: _refrash,
          );
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.bindLsData != null) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd.MM.yyyy kk:mm').format(now);

      dynamic message = MessageSend(
          cmd: "publish",
          subject: "store-${store_id}",
          event: "account_new",
          data: AccountNew(
              account_id: state.bindLsData!['account_id_last'],
              account_bind_number: lsController.text,
              account_bind_address: addressController.text,
              inn: user_inn,
              user_lk_id: int.parse(user_id!),
              date_add: formattedDate,
              type: "new"),
          to_id: int.parse(user_id!));
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Запрос на привязку отправлен!",
        btnOkOnPress: () {
          widget.refrash!.call();
          Navigator.pop(context);
        },
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
    webSocketChannel ??=
        DependencyProvider.of(context)!.webSocketChannel(false);
    super.didChangeDependencies();
  }
}
