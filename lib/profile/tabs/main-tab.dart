import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/profile/edit-profile-info/change-password-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../DI/dependency-provider.dart';
import '../../Services/profile-service.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-event.dart';
import '../../bloc/profile/profile-state.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../edit-profile-info/edit-user-info.dart';

class MainTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainTab();
}

class _MainTab extends State<MainTab> {
  ProfileBloc? profileBloc;
  ProfileService? profileService;

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scrollbar(
              child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(defaultSidePadding),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 21),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(defaultSidePadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ProfileText(
                                visibility: (profileService!.userType == "fl" ||
                                        profileService!.userType == "ip")
                                    ? true
                                    : false,
                                label: "ФИО",
                                text: profileService != null
                                    ? "${profileService!.userInformation!.lastname!} ${profileService!.userInformation!.firstname!} ${profileService!.userInformation!.patronymic!}"
                                    : ""),
                            ProfileText(
                                visibility: (profileService!.userType == "ul")
                                    ? true
                                    : false,
                                label: "Полное название организации",
                                text: profileService != null
                                    ? profileService!.userInformation!.company_full!
                                    : ""),
                            ProfileText(
                                visibility: (profileService!.userType == "ul")
                                    ? true
                                    : false,
                                label: "Сокращенное название организации",
                                text: profileService != null
                                    ? profileService!.userInformation!.company_short!
                                    : ""),
                                    
                            ProfileText(
                                visibility: true,
                                label: "Юридический адрес",
                                text: profileService != null
                                    ? profileService!
                                        .userInformation!.legal_address!
                                    : ""),
                            ProfileText(
                                visibility: true,
                                label: "Фактический адрес",
                                text: profileService != null
                                    ? profileService!
                                        .userInformation!.fact_address!
                                    : ""),    
                            ProfileText(
                                visibility: true,
                                label: "ИНН",
                                text: profileService != null
                                    ? profileService!.userInformation!.inn!
                                    : ""),

                            ProfileText(
                                visibility: profileService!.userType == "ip" ||
                                        profileService!.userType == "ul"
                                    ? true
                                    : false,
                                label: profileService!.userType == "ip" ? "ОГРНИП" : "ОГРН",
                                text: profileService != null
                                    ? profileService!.userInformation!.ogrn!
                                    : ""),
                            ProfileText(
                                visibility: profileService!.userType == "ul"
                                    ? true
                                    : false,
                                label: "КПП",
                                text: profileService != null
                                    ? profileService!.userInformation!.kpp!
                                    : ""),
                            ProfileText(
                                visibility: profileService!.userType == "fl"
                                    ? true
                                    : false,
                                label: "СНИЛС",
                                text: profileService != null
                                    ? profileService!.userInformation!.snils!
                                    : ""),
                            DefaultButton(
                                text: "Изменить пароль",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangePasswordScreen(
                                                  refrash: () {})));
                                },
                                isGetPadding: false),
                          ],
                        ),
                      ),
                    ),
                    DefaultButton(
                        text: "Редактировать",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditUserInfoPage()));
                        },
                        isGetPadding: false),
                  ],
                )),
          ));
        });
  }

  _listener(BuildContext context, ProfileState state) {}
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
  }
}

class ProfileText extends StatelessWidget {
  String label;
  String text;
  bool visibility;
  ProfileText(
      {required this.label, required this.text, required this.visibility});
  @override
  Widget build(BuildContext context) {
    return Visibility(
          visible: visibility,
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 15, color: colorGrayClaim),
              ),
              Text(
                text,
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
          ),
        );
  }
}
