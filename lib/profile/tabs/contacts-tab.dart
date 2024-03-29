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
import '../../model/user-information.dart';
/* 
contacts-tab.dart
Страница профиля (контакты)

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class ContactTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactTab();
}

class _ContactTab extends State<ContactTab> {
  ProfileBloc? profileBloc;
  ProfileService? profileService;
  EdutUserinfoService? edutUserinfoService;

  Map<String, Contact> contactsMap = {};

  bool isEdit = false;

  List<TextEditingController> numberController = [];

  List<GlobalKey<ColtactColtrolsState>> keys = [];

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scrollbar(
              child: ListView.builder(
                  itemCount: contactsMap.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, int i) {
                    String phoneString = profileService!.userInformation!
                            .user_info_contacts![i].value_contact ??
                        "";
                    
                    String type = profileService!.userInformation!.user_info_contacts![i].contact_type_group_id ?? "";
                    return Padding(padding: EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding), child: ExpansionTileElement(
                      header: 
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(type == "1" ? "Номер телефона" : type == "2" ? "Email-адрес" : type == "3" ? "Мессенджер" : "", style: labelTextStyle),
                            Visibility(
                                visible: (contactsMap.values.elementAt(i).isEdit == false) ? true : false,
                                child: Text(type == "1" ?
                                    "+7 (${phoneString[1]}${phoneString[2]}${phoneString[3]}) ${phoneString[4]}${phoneString[5]}${phoneString[6]}-${phoneString[7]}${phoneString[8]}-${phoneString[9]}${phoneString[10]}"
                                    : profileService!.userInformation!.user_info_contacts![i].value_contact!,
                                    //.replaceAllMapped(
                                    //    RegExp(r'[0-9\-\+]{9,15}$'), (Match m) => ""),
                                    style: TextStyle(fontSize: 18))),
                            Visibility(
                                visible: (contactsMap.values.elementAt(i).isEdit == true ) ? true : false,
                                child: 
                                TextFormField(
                                  controller: numberController[i],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Введите телефон";
                                    }
                                    return null;
                                  },
                                  inputFormatters: type == "1" ?  [
                                    MaskTextInputFormatter(
                                        mask: "+7 (###) ###-##-##")
                                  ] : [],
                                  keyboardType: TextInputType.phone,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                      hintText:  type == "1" ? "Телефон" :  type == "2" ? "Email" : type == "3" ? "Мессенджер" : "",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: inputBorder, width: 5.0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ))
                          ]),
                      tileText: Text("Настройки",
                          style: TextStyle(color: colorGrayClaim)),
                      body: ColtactColtrols(
                        key: keys[i],
                        contact_id: profileService!.userInformation!
                                    .user_info_contacts![i].contact_id!,
                        delegateFunction: switchToEdit,
                        isPhone: type == "1" ? true : false,
                        contactType: profileService!.userInformation!
                                    .user_info_contacts![i].contact_type_id ==
                                "1"
                            ? "Телефон стационарный"
                            : profileService!
                                        .userInformation!
                                        .user_info_contacts![i]
                                        .contact_type_id ==
                                    "2"
                                ? "Телефон мобильный"
                                : "",
                        IsLogin: (profileService!.userInformation!
                                        .user_info_contacts![i].flags !=
                                    null &&
                                profileService!.userInformation!
                                        .user_info_contacts![i].flags['1'] !=
                                    null)
                            ? true
                            : false,
                        IsClaims: (profileService!.userInformation!
                                        .user_info_contacts![i].flags !=
                                    null &&
                                profileService!.userInformation!
                                        .user_info_contacts![i].flags['2'] !=
                                    null)
                            ? true
                            : false,
                        IsTickets: (profileService!.userInformation!
                                        .user_info_contacts![i].flags !=
                                    null &&
                                profileService!.userInformation!
                                        .user_info_contacts![i].flags['2'] !=
                                    null)
                            ? true
                            : false,
                      ),
                    )
                 );
                    
                  }));
        });
  }

  _listener(BuildContext context, ProfileState state) {}

  void switchToEdit(String contact_id) {
    setState(() {
      isEdit = !isEdit;
      var contact = contactsMap[contact_id];
      contact!.isEdit = isEdit;
      contactsMap.update(contact_id, (value) => contact);
    });
  }

  void sendData(){
    
  }

  void addPhones() {

    contactsMap = {
      for (var e in profileService!.userInformation!.user_info_contacts!)
        e.contact_id!: e
    };

  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
    keys = List.generate(profileService!.userInformation!.user_info_contacts!.length, (index) => GlobalKey<ColtactColtrolsState>());
    
    edutUserinfoService ??= DependencyProvider.of(context)!.edutUserinfoService;
    addPhones();
    numberController = List<TextEditingController>.generate(contactsMap.length, (index) => TextEditingController());
    super.didChangeDependencies();
  }
}
