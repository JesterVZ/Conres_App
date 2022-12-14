import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../DI/dependency-provider.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../../model/object_pu.dart';
import '../../websocket/message-send.dart';

class LinkTu extends StatefulWidget {
  VoidCallback? refrash;
  ObjectPuModel currentPU;
  LinkTu({required this.currentPU, required this.refrash});
  @override
  State<StatefulWidget> createState() => _LinkTu();
}

class _LinkTu extends State<LinkTu> {
  Future<void> _refrash() async {}
    TextEditingController numberTuColtroller = TextEditingController();
    TextEditingController nameTuColtroller = TextEditingController();
    TextEditingController addressTuColtroller = TextEditingController();
    ProfileBloc? profileBloc;
    WebSocketChannel? webSocketChannel;
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    

    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
              header: HeaderNotification(text: "Привязать ТУ", canGoBack: true),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: defaultSidePadding, right: defaultSidePadding),
                      child: Form(
                      key: _formKey,
                      child:Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: DefaultInput(
                                labelText: "Номер ТУ",
                                hintText: "Номер ТУ",
                                validatorText: "Введите номер ТУ",
                                keyboardType: TextInputType.number,
                                controller: numberTuColtroller),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: DefaultInput(
                                labelText: "Наименование ТУ",
                                hintText: "Наименование ТУ",
                                validatorText: "Введите наименование ТУ",
                                keyboardType: TextInputType.text,
                                controller: nameTuColtroller),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: DefaultInput(
                                labelText: "Адрес ТУ",
                                hintText: "Адрес ТУ",
                                validatorText: "Введите адрус ТУ",
                                keyboardType: TextInputType.text,
                                controller: addressTuColtroller),
                          ),
                        ],
                      ))),
              ),
              footer: DefaultButton(
                isGetPadding: true,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                  
                  profileBloc!.bindNewTU(widget.currentPU.object_id!, numberTuColtroller.text, nameTuColtroller.text, addressTuColtroller.text);
                }
                },
                text: "Привязать ТУ",
              ),
              onRefrash: _refrash);
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }

    if(state.bindTuData != null){
      dynamic message = MessageSend(
                    cmd: "publish",
                    subject: "store-${store_id}",
                    event: "point_binding_new",
                    data: TuNew(
                      objectId: state.bindTuData!['object_id'],
                      newObjectName: state.bindTuData!['new_object_name'],
                      newObjectAddress: state.bindTuData!['new_object_address'],
                      code: state.bindTuData!['code'],
                      msg: state.bindTuData!['msg'],
                      pointId: state.bindTuData!['point_id'],
                      accountId: state.bindTuData!['account_id'],
                      accountNumber: state.bindTuData!['account_number'],
                      userLkId: state.bindTuData!['user_lk_id'],
                      dateAdded: state.bindTuData!['date_added'],
                      newPointNumber: numberTuColtroller.text,
                      newPointName: nameTuColtroller.text,
                      newPointAddress: addressTuColtroller.text,
                      html: ""
                    ),
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
        desc: "Запрос на привязку ТУ отправлен!",
        btnOkOnPress: () {
          widget.refrash!.call();
          Navigator.pop(context);
        },
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
