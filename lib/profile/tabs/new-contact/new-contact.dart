import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/Services/edit-userinfo-service.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/user-information.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../Services/profile-service.dart';
import '../../../UI/default-button.dart';
import '../../../UI/main-form.dart';
import '../../../bloc/profile/profile-bloc.dart';
import '../../../bloc/profile/profile-state.dart';
import '../../../consts.dart';
import '../../../elements/bloc/bloc-screen.dart';

class NewContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewContact();
}

class _NewContact extends State<NewContact> {
  ProfileBloc? profileBloc;
  EdutUserinfoService? edutUserinfoService;
  ProfileService? profileService;
  List dropdownList = [
    {'label': 'Телефон мобильный', 'value': '2'},
    {'label': 'Телефон стационарный', 'value': '1'},
  ];
  String typeIndex = '2';
  TextEditingController numberController = TextEditingController();
  bool isLogin = false;
  bool IsClaims = false;
  bool IsTickets = false;
  bool? isLoading;

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
            header: HeaderNotification(text: "Новый контакт", canGoBack: true),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                        key: _formKey,
                        child: Stack(
                          children: [
                            Column(children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: CoolDropdown(
                                  resultHeight: 55,
                                  resultTS: TextStyle(
                                    fontSize: 20,
                                    color: colorMain,
                                  ),
                                  resultBD: BoxDecoration(
                                    color: messageColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  selectedItemBD: BoxDecoration(
                                    color: messageColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  selectedItemTS: TextStyle(
                                    fontSize: 20,
                                    color: colorMain,
                                  ),
                                  dropdownBD: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(255, 49, 49, 49)
                                              .withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: Offset(0, 1),
                                        ),
                                      ]),
                                  dropdownWidth:
                                      MediaQuery.of(context).size.width - 50,
                                  dropdownHeight: 150,
                                  resultWidth:
                                      MediaQuery.of(context).size.width,
                                  dropdownList: dropdownList,
                                  defaultValue: dropdownList[0],
                                  onChange: (value) {
                                    typeIndex = value['value'];
                                  },
                                  //defaultValue: dropdownObjectsList[0],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Телефон",
                                      style: TextStyle(
                                          color: colorGray, fontSize: 16.0)),
                                  TextFormField(
                                    controller: numberController,
                                    inputFormatters: [
                                      MaskTextInputFormatter(
                                          mask: "+7 (###) ###-##-##")
                                    ],
                                    keyboardType: TextInputType.phone,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                        hintText: "Телефон",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: inputBorder, width: 5.0),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 12, bottom: 12),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(108, 229, 232, 237),
                                    borderRadius: BorderRadius.circular(10)),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 7, 20, 7),
                                child: Row(
                                  children: [
                                    Container(
                                      child: SvgPicture.asset(
                                          'assets/lock_profile.svg'),
                                      margin: EdgeInsets.only(right: 18),
                                    ),
                                    const Text(
                                      "Вход в качестве логина",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const Spacer(),
                                    Switch(
                                        value: isLogin,
                                        onChanged: (value) {
                                          setState(() {
                                            isLogin = value;
                                          });
                                        })
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 12, bottom: 12),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(108, 229, 232, 237),
                                    borderRadius: BorderRadius.circular(10)),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 7, 20, 7),
                                child: Row(
                                  children: [
                                    Container(
                                      child: SvgPicture.asset(
                                          'assets/lock_profile.svg'),
                                      margin: EdgeInsets.only(right: 18),
                                    ),
                                    const Text(
                                      "Заявления",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const Spacer(),
                                    Switch(
                                        value: IsClaims,
                                        onChanged: (value) {
                                          setState(() {
                                            IsClaims = value;
                                          });
                                        })
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 12, bottom: 12),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(108, 229, 232, 237),
                                    borderRadius: BorderRadius.circular(10)),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 7, 20, 7),
                                child: Row(
                                  children: [
                                    Container(
                                      child: SvgPicture.asset(
                                          'assets/lock_profile.svg'),
                                      margin: EdgeInsets.only(right: 18),
                                    ),
                                    const Text(
                                      "Обращения",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const Spacer(),
                                    Switch(
                                        value: IsTickets,
                                        onChanged: (value) {
                                          setState(() {
                                            IsTickets = value;
                                          });
                                        })
                                  ],
                                ),
                              ),
                            ]),
                            Visibility(
                                child: Center(
                                    child: Container(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                      color: colorMain),
                                )),
                                visible: (isLoading == true) ? true : false)
                          ],
                        )))),
            footer: DefaultButton(
              text: "Добавить номер",
              isGetPadding: true,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  edutUserinfoService!.tab = "contacts";
                  edutUserinfoService!.user_lk_id = user_id!;
                  switch (profileService!.userType) {
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
                  edutUserinfoService!.phones!.add(Contact(
                      contact_id: "0",
                      contact_type_group_id: "1",
                      contact_type_id: typeIndex,
                      value_contact: numberController.text,
                      flags: isLogin ? {'1': '1'} : null));
                  profileBloc!.editUserInfo(edutUserinfoService!);
                }
              },
            ),
          );
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    } else {
      isLoading = false;
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    edutUserinfoService ??= DependencyProvider.of(context)!.edutUserinfoService;
    profileService ??= DependencyProvider.of(context)!.profileService;
    super.didChangeDependencies();
  }
}
