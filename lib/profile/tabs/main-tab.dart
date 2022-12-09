import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../DI/dependency-provider.dart';
import '../../Services/profile-service.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../change-password/change-password-screen.dart';

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
                                visibility: profileService!.userType == "fl"
                                    ? true
                                    : false,
                                label: "ФИО",
                                text: profileService != null
                                    ? "${profileService!.userInformation!.lastname!} ${profileService!.userInformation!.firstname!} ${profileService!.userInformation!.patronymic!}"
                                    : ""),
                            ProfileText(
                                visibility: profileService!.userType == "fl"
                                    ? true
                                    : false,
                                label: "Юридический адрес",
                                text: profileService != null
                                    ? profileService!
                                        .userInformation!.legal_address!
                                    : ""),
                            ProfileText(
                                visibility: profileService!.userType == "fl"
                                    ? true
                                    : false,
                                label: "Фактический адрес",
                                text: profileService != null
                                    ? profileService!
                                        .userInformation!.legal_address!
                                    : ""),
                            ProfileText(
                                visibility: profileService!.userType == "fl"
                                    ? true
                                    : false,
                                label: "ИНН",
                                text: profileService != null
                                    ? profileService!.userInformation!.inn!
                                    : ""),
                            ProfileText(
                                visibility: profileService!.userType == "ip" ||
                                        profileService!.userType == "ul"
                                    ? true
                                    : false,
                                label: "ОГРН",
                                text: profileService != null
                                    ? profileService!.userInformation!.ogrn!
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
                                                refrash: () {},
                                              )));
                                },
                                isGetPadding: false),
                          ],
                        ),
                      ),
                    ),
                    DefaultButton(
                        text: "Редактировать",
                        onPressed: () {},
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
    return Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Visibility(
          visible: visibility,
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
        ));
  }
}
