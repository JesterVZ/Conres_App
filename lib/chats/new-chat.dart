import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UI/default-input.dart';
import '../UI/main-form.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/dropdown.dart';
import '../elements/header/header-notification.dart';

class NewChat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewChat();
}

class _NewChat extends State<NewChat> {
  TextEditingController FioController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController TextController = TextEditingController();
  ProfileBloc? profileBloc;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            header: HeaderRow(text: "Новое обращение", fontSize: 24),
            body: Form(
              child: Column(
                children: [
                  DefaultInput(
                      controller: FioController,
                      keyboardType: TextInputType.text,
                      labelText: "ФИО",
                      hintText: "Иванов Иван Иванович",
                      validatorText: "Введите ФИО"),
                  DefaultInput(
                      controller: FioController,
                      keyboardType: TextInputType.text,
                      labelText: "Email",
                      hintText: "Example@gmail.com",
                      validatorText: "Введите Email"),
                ],
              ),
            )));
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    super.didChangeDependencies();
  }
}
