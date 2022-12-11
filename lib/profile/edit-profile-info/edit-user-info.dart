import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/bloc/bloc-screen.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';

import '../../DI/dependency-provider.dart';
import '../../UI/default-input.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';

class EditUserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditUserInfoPage();
}

class _EditUserInfoPage extends State<EditUserInfoPage> {
  ProfileBloc? profileBloc;
  TextEditingController familyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController innController = TextEditingController();
  TextEditingController snilsController = TextEditingController();
  TextEditingController urAddressController = TextEditingController();
  TextEditingController factAddressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
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
                  HeaderNotification(text: "Изменить профиль", canGoBack: true),
              body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: DefaultInput(
                                    labelText: "Фамилия",
                                    hintText: "Фамилия",
                                    validatorText: "Введите фамилию",
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    controller: familyController)),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: DefaultInput(
                                    labelText: "Имя",
                                    hintText: "Имя",
                                    validatorText: "Введите имя",
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    controller: nameController)),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: DefaultInput(
                                    labelText: "Отчество",
                                    hintText: "Отчество",
                                    validatorText: "Введите отчество",
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    controller: patronymicController)),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: DefaultInput(
                                    labelText: "ИНН",
                                    hintText: "ИНН",
                                    validatorText: "Введите ИНН",
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    controller: innController)),
                            Container(
                                margin: EdgeInsets.only(bottom: 25),
                                child: DefaultInput(
                                    labelText: "СНИЛС",
                                    hintText: "СНИЛС",
                                    validatorText: "Введите СНИЛС",
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    controller: snilsController)),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: DefaultInput(
                                    labelText: "Пароль",
                                    hintText: "**********",
                                    validatorText: "Введите пароль",
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    controller: innController)),
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: DefaultInput(
                                    labelText: "Пароль",
                                    hintText: "**********",
                                    validatorText: "Введите пароль",
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    controller: innController)),
                            DefaultButton(
                              text: "Внести изменения",
                              isGetPadding: false,
                              onPressed: () {},
                            )
                          ],
                        ))),
              ),
              onRefrash: _refrash);
        });
  }

  _listener(BuildContext context, ProfileState state) {}
  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;

    super.didChangeDependencies();
  }
}
