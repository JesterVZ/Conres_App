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

class LinkTu extends StatefulWidget {
  ObjectPuModel currentPU;
  LinkTu({required this.currentPU});
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
                                keyboardType: TextInputType.number,
                                controller: numberTuColtroller),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: DefaultInput(
                                labelText: "Наименование ТУ",
                                hintText: "Наименование ТУ",
                                keyboardType: TextInputType.text,
                                controller: nameTuColtroller),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: DefaultInput(
                                labelText: "Адрес ТУ",
                                hintText: "Адрес ТУ",
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
                text: "Отправить запрос",
              ),
              onRefrash: _refrash);
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }

    if(state.bindTuData != null){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Успешно!",
        desc: "Запрос на привязку отправлен!",
        btnOkOnPress: () {
          //widget.refrash!.call();
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
