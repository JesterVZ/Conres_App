import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../DI/dependency-provider.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../../elements/alert.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../../elements/masks.dart';

class NewLS extends StatefulWidget {
  const NewLS({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewLS();
}

class _NewLS extends State<NewLS> {
  ProfileBloc? profileBloc;
  TextEditingController lsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(numberLS, style: labelTextStyle),
                                  MaskInput(
                                    formatter: MaskTextInputFormatter(
                                        mask: "#########"),
                                    textController: lsController,
                                    type: "ls",
                                    hint: "000000000",
                                  )
                                ],
                              )),
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
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Успешно!", text: state.bindLsData!));
      Navigator.pop(context);
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
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
  }
}
