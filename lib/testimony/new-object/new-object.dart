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
class NewObject extends StatefulWidget {
  VoidCallback? refrash;
  NewObject({Key? key, required this.refrash}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewObject();
}

class _NewObject extends State<NewObject> {
  ProfileBloc? profileBloc;
  TextEditingController nameController = TextEditingController();
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
            header: HeaderNotification(text: "Новый ЛС", canGoBack: true),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                              child: DefaultInput(
                              labelText: "Наименование объекта",
                              hintText: "Дом / Квартира",
                              validatorText: "Введите адрес объекта",
                              keyboardType: TextInputType.text,
                              controller: nameController)),
                          DefaultInput(
                              labelText: "Адрес объекта",
                              hintText: "Город, Улица, Дом, Квартира",
                              validatorText: "Введите адрес объекта",
                              keyboardType: TextInputType.text,
                              controller: addressController)
                        ],
                      ),
                    ))),
            footer: DefaultButton(
              text: "Добавить объект",
              isGetPadding: true,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  profileBloc!.bindNewObject(nameController.text, addressController.text);
                  //profileBloc!.bindNewLS(lsController.text, addressController.text);
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
    if (state.bindObjectData != null) {

      dynamic message = MessageSend(
                    cmd: "publish",
                    subject: "store-${store_id}",
                    event: "object_binding_new",
                    data: ObjectNew(
                      object_id: state.bindObjectData!['object_id'],
                      account_id: state.bindObjectData!['account_id'],
                      account_number: state.bindObjectData!['account_number'],
                      date_added: state.bindObjectData!['date_added'],
                      user_lk_id: state.bindObjectData!['user_lk_id'],
                      object_name: nameController.text,
                      object_address: addressController.text),
                    to_id: int.parse(user_id!)
                  );
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Запрос на привязку объекта отправлен!",
        btnOkOnPress: () {
          widget.refrash!.call();
          Navigator.pop(context);
        },
        ).show();
    }
    if (state.error != null) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Ошибка!",
        btnOkColor: Colors.red,
        desc: state.error,
        btnOkOnPress: () {},
      ).show();

    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel(false);
    super.didChangeDependencies();
   
  }
}
