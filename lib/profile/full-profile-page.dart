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
import '../elements/full-profile/ExpansionTileElement.dart';

class FullProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullProfile();
}

class _FullProfile extends State<FullProfile>
    with SingleTickerProviderStateMixin {
  ProfileBloc? profileBloc;
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
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: BlocScreen<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          listener: (context, state) => _listener(context, state),
          builder: (context, state) {
          return Scaffold(
              backgroundColor: defaultBackground,
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    margin: const EdgeInsets.only(bottom: 14),
                    child: HeaderNotification(text: "Информация"),
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
                    child: TabBarView(controller: tabController, children: [
                      Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Container(
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
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("ФИО",
                                                      style: TextStyle(
                                                          color:
                                                              colorGrayClaim)),
                                                  Text(
                                                      userInformation != null
                                                          ? userInformation!
                                                              .firstname!
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              )),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Юридический адрес",
                                                      style: TextStyle(
                                                          color:
                                                              colorGrayClaim)),
                                                  Text(
                                                      userInformation != null &&
                                                              userInformation!
                                                                      .legal_address !=
                                                                  null
                                                          ? userInformation!
                                                              .legal_address!
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              )),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("ИНН",
                                                      style: TextStyle(
                                                          color:
                                                              colorGrayClaim)),
                                                  Text(
                                                      userInformation != null
                                                          ? userInformation!
                                                              .inn!
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              )),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("ОГРНИП",
                                                      style: TextStyle(
                                                          color:
                                                              colorGrayClaim)),
                                                  Text(
                                                      userInformation != null
                                                          ? userInformation!
                                                              .ogrn!
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              )),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Пароль",
                                                      style: TextStyle(
                                                          color:
                                                              colorGrayClaim)),
                                                  const Text("************",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 55,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Редактировать"),
                                    style: ElevatedButton.styleFrom(
                                        primary: colorMain,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)))),
                              ),
                              Container(
                                child: Column(children: [
                                  const Text("Быстрая авторизация",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 24)),
                                  Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 264,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/vk-svg.svg'),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 21),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text("Вконтакте",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18)),
                                                            Text("Запрещенно")
                                                          ],
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xFFC8D8FF),
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 5,
                                                                color: const Color(
                                                                    0xFFF2F6FF))),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/Google-svg.svg'),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 21),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text("Google",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18)),
                                                            Text("Запрещенно")
                                                          ],
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xFFC8D8FF),
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 5,
                                                                color: const Color(
                                                                    0xFFF2F6FF))),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/Yandex-svg.svg'),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 21),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text("Yandex",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18)),
                                                            Text("Запрещенно")
                                                          ],
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xFFC8D8FF),
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 5,
                                                                color: const Color(
                                                                    0xFFF2F6FF))),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/OK-svg.svg'),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 21),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                                "Одноклассники",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18)),
                                                            Text("Запрещенно")
                                                          ],
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xFFC8D8FF),
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 5,
                                                                color: const Color(
                                                                    0xFFF2F6FF))),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )))
                                ]),
                              )
                            ],
                          ),
                        ),
                      ),
                      Scrollbar(
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
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    ExpansionTileElement(),
                                    const Text("E-mail",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    ExpansionTileElement(),
                                    const Text("Мессенджеры",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    ExpansionTileElement(),
                                    /*
                    const Text("E-mail",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    ContactBlock(),
                    const Text("Мессенджеры",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    ContactBlock(),
                    */
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
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
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("ФИО доверенного лица",
                                                      style: TextStyle(
                                                          color:
                                                              colorGrayClaim)),
                                                  const Text(
                                                      "Иванов2 Иван Иванович",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              )),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "E-mail доверенного лица",
                                                      style: TextStyle(
                                                          color:
                                                              colorGrayClaim)),
                                                  const Text(
                                                      "ahiro2011@gmail.com",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              )),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Телефон доверенного лица",
                                                      style: TextStyle(
                                                          color:
                                                              colorGrayClaim)),
                                                  const Text(
                                                      "+7 (919) 466-45-92",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 55,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Редактировать"),
                                    style: ElevatedButton.styleFrom(
                                        primary: colorMain,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)))),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  )
                ],
              ));
        }));

  }

   _listener(BuildContext context, ProfileState state) {
    if(state.loading == true){
      return;
    }
    if(state.userInformation != null){
      setState(() {
        userInformation = state.userInformation;
      });
    }
   }
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getFullProfileInfo();
  }
}
