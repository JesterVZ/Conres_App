import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/bloc/bloc-screen.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../DI/dependency-provider.dart';
import '../../Services/edit-userinfo-service.dart';
import '../../Services/profile-service.dart';
import '../../UI/default-input.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../../websocket/message-send.dart';
/* 
edit-user-info.dart
Редактирование профиля
TODO пересмотреть дизайн экрана полностью

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class EditUserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditUserInfoPage();
}

class _EditUserInfoPage extends State<EditUserInfoPage> {
  ProfileBloc? profileBloc;
  WebSocketChannel? webSocketChannel;
  EdutUserinfoService? edutUserinfoService;
  TextEditingController familyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController companyFullController = TextEditingController();
  TextEditingController companyShortController = TextEditingController();

  TextEditingController innController = TextEditingController();
  TextEditingController snilsController = TextEditingController();
  TextEditingController ogrnController = TextEditingController();
  TextEditingController kppController = TextEditingController();

  TextEditingController urAddressController = TextEditingController();
  TextEditingController factAddressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  ProfileService? profileService;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  List<EditRequest> familyRequests = [];
  List<EditRequest> nameRequests = [];
  List<EditRequest> patronymicRequests = [];

  List<EditRequest> fullNameRequests = [];
  List<EditRequest> shortNameRequests = [];

  List<EditRequest> innRequests = [];
  List<EditRequest> kppRequests = [];
  List<EditRequest> ogrnRequests = [];
  List<EditRequest> snilsRequests = [];

  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return 
    BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child:
          MainForm(
              header:
                  HeaderNotification(text: "Изменить профиль", canGoBack: true),
              body: Stack(
                children: [
SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Visibility(
                              visible: (profileService!.userType == "fl" ||
                                        profileService!.userType == "ip")
                                    ? true
                                    : false,
                              child: Column(
                                children: [
                                  DefaultInput(
                                      labelText: "Фамилия",
                                      hintText: "Фамилия",
                                      validatorText: "Введите фамилию",
                                      keyboardType: TextInputType.text,
                                      controller: familyController),
                                  Column(
                                    children: familyRequests,
                                  )
                                ],
                              )),
                            Visibility(
                              visible: (profileService!.userType == "fl" ||
                                        profileService!.userType == "ip")
                                    ? true
                                    : false,
                              child: Column(
                                children: [
                                  DefaultInput(
                                      labelText: "Имя",
                                      hintText: "Имя",
                                      validatorText: "Введите имя",
                                      keyboardType: TextInputType.text,
                                      controller: nameController),
                                  Column(
                                    children: nameRequests,
                                  )
                                ],
                              ),),
                            Visibility(
                              visible: (profileService!.userType == "fl" ||
                                        profileService!.userType == "ip")
                                    ? true
                                    : false,
                              child: Column(
                                children: [
                                  DefaultInput(
                                      labelText: "Отчество",
                                      hintText: "Отчество",
                                      validatorText: "Введите отчество",
                                      keyboardType: TextInputType.text,
                                      controller: patronymicController),
                                  Column(
                                    children: patronymicRequests,
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: (profileService!.userType == "ul")
                                    ? true
                                    : false,
                              child: Column(
                                children: [
                                  DefaultInput(
                                      labelText: "Полное название организации",
                                      hintText: "Полное название организации",
                                      validatorText: "Введите полное название организации",
                                      keyboardType: TextInputType.text,
                                      controller: companyFullController),
                                  Column(
                                    children: fullNameRequests,
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: (profileService!.userType == "ul")
                                    ? true
                                    : false,
                              child: Column(
                                children: [
                                  DefaultInput(
                                      labelText: "Сокращенное название организации",
                                      hintText: "Полное название организации",
                                      validatorText: "Введите сокращенное название организации",
                                      keyboardType: TextInputType.text,
                                      controller: companyShortController),
                                  Column(
                                    children: shortNameRequests,
                                  )
                                ],
                              ),
                            ),
                            
                            Column(
                              children: [
                                DefaultInput(
                                    labelText: "ИНН",
                                    hintText: "ИНН",
                                    keyboardType: TextInputType.text,
                                    controller: innController),
                                Column(
                                    children: innRequests,
                                  )
                              ],
                            ),
                            
                            Visibility(
                              visible: profileService!.userType == "ul"
                                    ? true
                                    : false,
                              child: Column(
                                children: [
                                  DefaultInput(
                                      labelText: "КПП",
                                      hintText: "КПП",
                                      keyboardType: TextInputType.text,
                                      controller: kppController),
                                  Column(
                                    children: kppRequests,
                                  )
                                ],
                              )),
                            Visibility(
                              visible: profileService!.userType == "ip" ||
                                        profileService!.userType == "ul"
                                    ? true
                                    : false,
                              child: Column(
                                children: [
                                  DefaultInput(
                                      labelText:  profileService!.userType == "ip" ? "ОГРНИП" : "ОГРН",
                                      hintText:  profileService!.userType == "ip" ? "ОГРНИП" : "ОГРН",
                                      keyboardType: TextInputType.text,
                                      controller: ogrnController),
                                  Column(
                                    children: ogrnRequests,
                                  )
                                ],
                              )),
                            Visibility(
                              visible: profileService!.userType == "fl"
                                    ? true
                                    : false,
                              child: Column(
                                children: [
                                  DefaultInput(
                                      labelText: "СНИЛС",
                                      hintText: "СНИЛС",
                                      keyboardType: TextInputType.text,
                                      controller: snilsController),
                                  Column(
                                    children: snilsRequests,
                                  )
                                ],
                              )),
                            
                            DefaultInput(
                                labelText: "Юридический адрес",
                                hintText: "Юридический адрес",
                                keyboardType: TextInputType.text,
                                controller: urAddressController),
                            DefaultInput(
                                labelText: "Фактический адрес",
                                hintText: "Юридический адрес",
                                keyboardType: TextInputType.text,
                                controller: factAddressController),
                            DefaultInput(
                                labelText: "Новый пароль",
                                hintText: "**********",
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                controller: passwordController),
                            DefaultInput(
                                labelText: "Повторите новый пароль",
                                hintText: "**********",
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                controller: confirmpasswordController),
                            DefaultButton(
                              text: "Внести изменения",
                              isGetPadding: false,
                              onPressed: () {
                                if(_formKey.currentState!.validate()){

                                  if(passwordController.text == confirmpasswordController.text){
                                    edutUserinfoService!.tab = "general";
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
                                    edutUserinfoService!.firstname = nameController.text;
                                    edutUserinfoService!.lastname = familyController.text;
                                    edutUserinfoService!.patronymic = patronymicController.text;
                                    edutUserinfoService!.company_full = companyFullController.text;
                                    edutUserinfoService!.company_short = companyShortController.text;
                                    edutUserinfoService!.inn = innController.text;
                                    edutUserinfoService!.ogrn = ogrnController.text;
                                    edutUserinfoService!.kpp = kppController.text;
                                    edutUserinfoService!.legal_address = urAddressController.text;
                                    edutUserinfoService!.fact_address = factAddressController.text;
                                    edutUserinfoService!.snins = snilsController.text;
                                    edutUserinfoService!.password = passwordController.text;
                                    edutUserinfoService!.confirm = confirmpasswordController.text;
                                    
                                    profileBloc!.editUserInfo(edutUserinfoService!);
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.bottomSlide,
                                      headerAnimationLoop: false,
                                      title: "Ошибка!",
                                      desc: "Пароли не совпадают!",
                                      btnOkColor: Colors.red,
                                      btnOkOnPress: () {
                                      },
                                      ).show();
                                  }
                                  
                                }
                              },
                            )
                          ],
                        ))),
              ),
              Visibility(
                          child: Center(
                              child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(color: colorMain),
                          )),
                          visible: (isLoading == true) ? true : false)
                ],
              ),
              
              onRefrash: _refrash));
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    } else {
      isLoading = false;
    }

    if(state.editUserInfoData != null){
      List<UserEditInfo> fields = [];
      for(int i = 0; i < state.editUserInfoData!['user_edit_info'].length; i++){
        fields.add(UserEditInfo.fromJson(state.editUserInfoData!['user_edit_info'][i]));
      }
      dynamic message = MessageSend(
        cmd: "publish",
        subject: "store-${store_id}",
        event: "user_info_new",
        data: UserInfoEdit(
          userLkId: state.editUserInfoData!['user_lk_id'],
          userFio: state.editUserInfoData!['user_fio'],
          userEditInfo: fields
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
        desc: "Новая информация о пользователе отправлена на рассмотрение!",
        btnOkOnPress: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ).show();
    }

    if(state.error != null){
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
    profileService ??= DependencyProvider.of(context)!.profileService;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel(false);
    edutUserinfoService ??= DependencyProvider.of(context)!.edutUserinfoService;
    familyController.text = profileService!.userInformation!.lastname!;
    nameController.text = profileService!.userInformation!.firstname!;
    patronymicController.text = profileService!.userInformation!.patronymic!;
    companyFullController.text = profileService!.userInformation!.company_full!;
    companyShortController.text = profileService!.userInformation!.company_short!;

    innController.text = profileService!.userInformation!.inn!;
    snilsController.text = profileService!.userInformation!.snils!;
    ogrnController.text = profileService!.userInformation!.ogrn!;
    kppController.text = profileService!.userInformation!.kpp!;
    
    urAddressController.text = profileService!.userInformation!.legal_address!;
    factAddressController.text = profileService!.userInformation!.fact_address!;

    for(int i = 0; i < profileService!.userInformation!.requests!.length; i++){
      String fieldname = profileService!.userInformation!.requests![i].uidField ?? "";
      /*
      switch (fieldname){
        case  "lastname":
          familyRequests.add(EditRequest(text: ,))
      }
      */
    }
     familyRequests.add(EditRequest(text: "test",));
    super.didChangeDependencies();
  }
}


class EditRequest extends StatelessWidget{
  String text;
  EditRequest({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: yellowColor
      ),
      child: Center(child: Text(text, style: TextStyle(color: Colors.white),)),
    );
  }
}