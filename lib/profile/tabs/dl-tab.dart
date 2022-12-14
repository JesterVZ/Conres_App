import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../DI/dependency-provider.dart';
import '../../UI/default-button.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../../elements/full-profile/ExpansionTileElement.dart';
import '../../elements/profile/contact-controls.dart';
import '../edit-profile-info/edit-proxy-info.dart';
import 'main-tab.dart';

class DlTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DlTab();
}

class _DlTab extends State<DlTab> {
  ProfileBloc? profileBloc;
  ProfileService? profileService;

  List<Widget> phones = [];
  List<Widget> emails = [];
  List<Widget> messangers = [];

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
                                visibility: true,
                                label: "ФИО доверенного лица",
                                text: profileService != null
                                    ? "${profileService!.userInformation!.proxy_lastname!} ${profileService!.userInformation!.proxy_firstname!} ${profileService!.userInformation!.proxy_patronymic!}"
                                    : ""),
                            ProfileText(
                                visibility: true,
                                label: "E-mail доверенного лица",
                                text: profileService != null
                                    ? profileService!
                                        .userInformation!.proxy_email!
                                    : ""),
                            ProfileText(
                                visibility: profileService!.userType == "fl"
                                    ? true
                                    : false,
                                label: "Телефон доверенного лица",
                                text: profileService != null
                                    ? profileService!
                                        .userInformation!.proxy_telephone!
                                    : ""),
                          ],
                        ),
                      ),
                    ),
                    DefaultButton(
                        text: "Редактировать",
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProxyInfo()));
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
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;

    super.didChangeDependencies();
  }
}
