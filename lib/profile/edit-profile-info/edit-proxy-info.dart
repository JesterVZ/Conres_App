import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/bloc/bloc-screen.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../DI/dependency-provider.dart';
import '../../Services/edit-userinfo-service.dart';
import '../../Services/profile-service.dart';
import '../../UI/default-input.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';

class EditProxyInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProxyInfo();
}

class _EditProxyInfo extends State<EditProxyInfo> {
  ProfileBloc? profileBloc;
  ProfileService? profileService;
  EdutUserinfoService? edutUserinfoService;
  TextEditingController familyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
              onRefrash: _refrash,
              header:
                  HeaderNotification(text: "Доверенное лицо", canGoBack: true),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: defaultSidePadding, right: defaultSidePadding),
                      child: Form(
                          key: _formKey,
                          child: Stack(children: [
                            Column(children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: DefaultInput(
                                    labelText: "Фамилия доверенного лица",
                                    hintText: "Фамилия доверенного лица",
                                    validatorText: "Введите фамилию",
                                    keyboardType: TextInputType.text,
                                    controller: familyController),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: DefaultInput(
                                    labelText: "Имя доверенного лица",
                                    hintText: "Имя доверенного лица",
                                    validatorText: "Введите имя",
                                    keyboardType: TextInputType.text,
                                    controller: nameController),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Отчество доверенного лица",
                                                    style: TextStyle(color: colorGray, fontSize: 16.0)),
                                                TextFormField(
                                                  controller: patronymicController,
                                                  keyboardType: TextInputType.phone,
                                                  autocorrect: false,
                                                  decoration: InputDecoration(
                                                      hintText: "Отчество доверенного лица",
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(color: inputBorder, width: 5.0),
                                                          borderRadius: BorderRadius.circular(10)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(10))),
                                                ),
                                              ],
                                            ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Номер телефона доверенного лица",
                                                    style: TextStyle(color: colorGray, fontSize: 16.0)),
                                                TextFormField(
                                                  controller: numberController,
                                                  validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return "Введите номер телефона";
                                                      }
                                                      return null;
                                                    },
                                                  inputFormatters: [MaskTextInputFormatter(
                                                            mask:
                                                                "+7 (###) ###-##-##")],
                                                  keyboardType: TextInputType.phone,
                                                  autocorrect: false,
                                                  decoration: InputDecoration(
                                                      hintText: "Телефон",
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(color: inputBorder, width: 5.0),
                                                          borderRadius: BorderRadius.circular(10)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(10))),
                                                ),
                                              ],
                                            ),
                              ),
                            Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: DefaultInput(
                                    labelText: "Адрес электронной почты доверенного лица",
                                    hintText: "Адрес электронной почты доверенного лица",
                                    validatorText: "Введите адрес электронной почты",
                                    keyboardType: TextInputType.text,
                                    controller: emailController),
                              ),
                            
                            ])
                          ])))),
                  footer: DefaultButton(
                              text: "Сохранить", 
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  edutUserinfoService!.user_lk_id = user_id!;
                                    switch(profileService!.userType){
                                      case "fl":
                                        edutUserinfoService!.user_lk_type_id = "1";
                                      break;
                                      case "ip":
                                        edutUserinfoService!.user_lk_type_id = "2";
                                      break;
                                      case "ul":
                                        edutUserinfoService!.user_lk_type_id = "3";
                                      break;
                                    }
                                  edutUserinfoService!.tab = "proxy";
                                  edutUserinfoService!.proxy_lastname = familyController.text;
                                  edutUserinfoService!.proxy_firstname = nameController.text;
                                  edutUserinfoService!.proxy_patronymic = patronymicController.text;
                                  edutUserinfoService!.proxy_email = emailController.text;
                                  edutUserinfoService!.proxy_telephone = numberController.text;
                                  profileBloc!.editUserInfo(edutUserinfoService!);
                                }
                              }, 
                              isGetPadding: true),);
        });
  }

  _listener(BuildContext context, ProfileState state) {}

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
    edutUserinfoService ??= DependencyProvider.of(context)!.edutUserinfoService;
    super.didChangeDependencies();
  }
}
