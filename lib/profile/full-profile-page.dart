import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/user-information.dart';
import 'package:conres_app/profile/tabs/contacts-tab.dart';
import 'package:conres_app/profile/tabs/dl-tab.dart';
import 'package:conres_app/profile/tabs/main-tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../DI/dependency-provider.dart';
import '../Services/edit-userinfo-service.dart';
import '../bloc/auth/auth-block.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/full-profile/ExpansionTileElement.dart';

class FullProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullProfile();
}

class _FullProfile extends State<FullProfile>
    with SingleTickerProviderStateMixin {
  ProfileBloc? profileBloc;
  ProfileService? profileService;
  EdutUserinfoService? edutUserinfoService;

  TabController? tabController;
  List<Tab> tabs = [];
  List<Widget> tabControllerChold = [];
  @override
  void initState() {
    //tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future<void> _refrash() async {}

  @override
  Widget build(BuildContext context) {
    return MainForm(
        header: HeaderNotification(text: "Информация", canGoBack: true),
        body: BlocScreen<ProfileBloc, ProfileState>(
            bloc: profileBloc,
            listener: (context, state) => _listener(context, state),
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: defaultBackground,
                  body: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TabBar(
                          controller: tabController,
                          tabs: tabs,
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.white,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colorMain),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                            controller: tabController,
                            children: tabControllerChold),
                      )
                    ],
                  ));
            }),
        onRefrash: _refrash);
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.userInformation != null) {
      edutUserinfoService!.firstname = state.userInformation!.firstname;
      edutUserinfoService!.lastname = state.userInformation!.lastname;
      edutUserinfoService!.patronymic = state.userInformation!.patronymic;
      edutUserinfoService!.company_full = state.userInformation!.company_full;
      edutUserinfoService!.company_short = state.userInformation!.company_short;
      edutUserinfoService!.inn = state.userInformation!.inn;
      edutUserinfoService!.ogrn = state.userInformation!.ogrn;
      edutUserinfoService!.kpp = state.userInformation!.kpp;
      edutUserinfoService!.legal_address = state.userInformation!.legal_address;
      edutUserinfoService!.fact_address = state.userInformation!.fact_address;
      edutUserinfoService!.snins = state.userInformation!.snils;
      if(edutUserinfoService!.phones!.isEmpty){
        for(int i = 0; i < profileService!.userInformation!.user_info_contacts!.length; i++){
          edutUserinfoService!.phones!
              .add(profileService!.userInformation!.user_info_contacts![i]);
      }
      }
      

      
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
    edutUserinfoService ??= DependencyProvider.of(context)!.edutUserinfoService;
    profileBloc!.getFullProfileInfo();

    if (profileService!.userType == "fl") {
      tabs = [
        const Tab(
          icon: Icon(Icons.home),
          text: "Общие",
        ),
        const Tab(
          icon: Icon(Icons.phone),
          text: "Контакты",
        )
      ];
      tabControllerChold = [MainTab(), ContactTab()];
    } else {
      tabs = [
        const Tab(
          icon: Icon(Icons.home),
          text: "Общие",
        ),
        const Tab(
          icon: Icon(Icons.phone),
          text: "Контакты",
        ),
        const Tab(
          icon: Icon(Icons.person),
          text: "Дов. лицо",
        )
      ];
      tabControllerChold = [MainTab(), ContactTab(), DlTab()];
    }

    tabController = TabController(length: tabs.length, vsync: this);
  }
}
