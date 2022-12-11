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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
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
