import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../DI/dependency-provider.dart';
import '../../Services/edit-userinfo-service.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../../elements/full-profile/ExpansionTileElement.dart';
import '../../elements/profile/contact-controls.dart';

class ContactTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactTab();
}

class _ContactTab extends State<ContactTab> {
  ProfileBloc? profileBloc;
  ProfileService? profileService;
  EdutUserinfoService? edutUserinfoService;

  List<Widget> phones = [];
  List<Widget> emails = [];
  List<Widget> messangers = [];

  bool isEdit = false;

  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Телефоны",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Column(children: phones),
                        const Text("E-mail",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Column(children: emails),
                        const Text("Мессенджеры",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Column(children: messangers),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _listener(BuildContext context, ProfileState state) {}

  void switchToEdit() {
    setState(() {
      isEdit = !isEdit;
      addPhones();
    });
  }

  void addPhones() {
    phones.clear();
    emails.clear();
    messangers.clear();

    for (int i = 0;
        i < profileService!.userInformation!.user_info_contacts!.length;
        i++) {
      if (profileService!
              .userInformation!.user_info_contacts![i].contact_type_group_id ==
          "1") {
        String phoneString = profileService!
                .userInformation!.user_info_contacts![i].value_contact ??
            "";
        if (phoneString != "") {
          phones.add(ExpansionTileElement(
            header:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Номер телефона", style: labelTextStyle),
              Visibility(
                  visible: isEdit == false ? true : false,
                  child: Text(
                      "+7 (${phoneString[1]}${phoneString[2]}${phoneString[3]}) ${phoneString[4]}${phoneString[5]}${phoneString[6]}-${phoneString[7]}${phoneString[8]}-${phoneString[9]}${phoneString[10]}",
                      //.replaceAllMapped(
                      //    RegExp(r'[0-9\-\+]{9,15}$'), (Match m) => ""),
                      style: TextStyle(fontSize: 18))),
              Visibility(
                  visible: isEdit == true ? true : false,
                  child: TextFormField(
                    controller: numberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите номер телефона";
                      }
                      return null;
                    },
                    inputFormatters: [
                      MaskTextInputFormatter(mask: "+7 (###) ###-##-##")
                    ],
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: "Телефон",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: inputBorder, width: 5.0),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ))
            ]),
            tileText:
                Text("Настройки", style: TextStyle(color: colorGrayClaim)),
            body: ColtactColtrols(
              delegateFunction: switchToEdit,
              isPhone: true,
              contactType: profileService!.userInformation!
                          .user_info_contacts![i].contact_type_id ==
                      "1"
                  ? "Телефон стационарный"
                  : profileService!.userInformation!.user_info_contacts![i]
                              .contact_type_id ==
                          "2"
                      ? "Телефон мобильный"
                      : "",
              IsLogin: (profileService!
                              .userInformation!.user_info_contacts![i].flags !=
                          null &&
                      profileService!.userInformation!.user_info_contacts![i]
                              .flags['1'] !=
                          null)
                  ? true
                  : false,
              IsClaims: (profileService!
                              .userInformation!.user_info_contacts![i].flags !=
                          null &&
                      profileService!.userInformation!.user_info_contacts![i]
                              .flags['2'] !=
                          null)
                  ? true
                  : false,
              IsTickets: (profileService!
                              .userInformation!.user_info_contacts![i].flags !=
                          null &&
                      profileService!.userInformation!.user_info_contacts![i]
                              .flags['2'] !=
                          null)
                  ? true
                  : false,
            ),
          ));
          edutUserinfoService!.phones!
              .add(profileService!.userInformation!.user_info_contacts![i]);
        }
      }

      if (profileService!
              .userInformation!.user_info_contacts![i].contact_type_group_id ==
          "2") {
        emails.add(ExpansionTileElement(
            header: Text(
                profileService!
                    .userInformation!.user_info_contacts![i].value_contact!,
                style: TextStyle(fontSize: 18)),
            body: ColtactColtrols(
              isPhone: false,
              IsLogin: (profileService!
                              .userInformation!.user_info_contacts![i].flags !=
                          null &&
                      profileService!.userInformation!.user_info_contacts![i]
                              .flags['1'] !=
                          null)
                  ? true
                  : false,
              IsClaims: (profileService!
                              .userInformation!.user_info_contacts![i].flags !=
                          null &&
                      profileService!.userInformation!.user_info_contacts![i]
                              .flags['2'] !=
                          null)
                  ? true
                  : false,
              IsTickets: (profileService!
                              .userInformation!.user_info_contacts![i].flags !=
                          null &&
                      profileService!.userInformation!.user_info_contacts![i]
                              .flags['2'] !=
                          null)
                  ? true
                  : false,
            ),
            tileText:
                Text("Настройки", style: TextStyle(color: colorGrayClaim))));
        edutUserinfoService!.emails!
            .add(profileService!.userInformation!.user_info_contacts![i]);
      }

      if (profileService!
              .userInformation!.user_info_contacts![i].contact_type_group_id ==
          "3") {
        messangers.add(ExpansionTileElement(
            header: Text(
                profileService!
                    .userInformation!.user_info_contacts![i].value_contact!,
                style: TextStyle(fontSize: 18)),
            body: ColtactColtrols(
              isPhone: false,
              IsLogin: (profileService!
                              .userInformation!.user_info_contacts![i].flags !=
                          null &&
                      profileService!.userInformation!.user_info_contacts![i]
                              .flags['1'] !=
                          null)
                  ? true
                  : false,
              IsClaims: (profileService!
                              .userInformation!.user_info_contacts![i].flags !=
                          null &&
                      profileService!.userInformation!.user_info_contacts![i]
                              .flags['2'] !=
                          null)
                  ? true
                  : false,
              IsTickets: (profileService!
                              .userInformation!.user_info_contacts![i].flags !=
                          null &&
                      profileService!.userInformation!.user_info_contacts![i]
                              .flags['2'] !=
                          null)
                  ? true
                  : false,
            ),
            tileText:
                Text("Настройки", style: TextStyle(color: colorGrayClaim))));
        edutUserinfoService!.messangers!
            .add(profileService!.userInformation!.user_info_contacts![i]);
      }
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
    edutUserinfoService ??= DependencyProvider.of(context)!.edutUserinfoService;
    addPhones();
    super.didChangeDependencies();
  }
}
