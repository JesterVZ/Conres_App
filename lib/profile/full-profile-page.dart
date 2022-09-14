import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/user-information.dart';
import 'package:conres_app/profile/tabs/confidant-tab.dart';
import 'package:conres_app/profile/tabs/contacts-tab.dart';
import 'package:conres_app/profile/tabs/info-tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../elements/bloc/bloc-screen.dart'; 

class FullProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullProfile();
}

class _FullProfile extends State<FullProfile>
    with SingleTickerProviderStateMixin {
      
  UserInformation? userInformation;
  TabController? tabController;
  List<Tab> tabs = [
    const Tab(
      icon: Icon(Icons.home),
      text: "Общие",
    ),
    const Tab(
      icon: Icon(Icons.phone),
      text: "Контакты",
    ),
    const Tab(
      icon: Icon(Icons.lock),
      text: "Дов. лицо",
    )
  ];
  List<Widget> panels = [
    InfoTab(),
    ContactsTab(),
    ConfidantTab(),
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
              length: 3,
              child: Scaffold(
                  backgroundColor: defaultBackground,
                  body: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        margin: const EdgeInsets.only(bottom: 14),
                        child: HeaderNotification(text: "Основная информация"),
                      ),
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
                            controller: tabController, children: panels),
                      )
                    ],
                  )));
  }
}
