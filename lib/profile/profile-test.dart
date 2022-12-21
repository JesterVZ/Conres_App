import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/UI/skeleton.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/contracts/contracts.dart';
import 'package:conres_app/profile/tab-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../DI/dependency-provider.dart';
import '../Services/bottom-navigation-select-service.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header-notification.dart';
import '../model/contract.dart';
import '../model/profile.dart';
import '../testimony/send-testimony.dart';

class ProfilePageTest extends StatefulWidget {
  ProfilePageTest({Key? key, required this.func}) : super(key: key);
  ValueChanged<Contract> func;

  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePageTest> {
  AuthBloc? authBloc;
  ProfileBloc? profileBloc;
  Profile? profile;
  ProfileService? profileService;
  BottomNavigationSelectService? bottomNavigationSelectService;

  bool? isLoading = true;

  Future<void> _refrash() async {
    authBloc!.loginWithCookies(); //get info old
    setState(() {
      profile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double bottomButtonWidth = MediaQuery.of(context).size.width;
    double size = bottomButtonWidth * 0.045;
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
            footerHeight: 100,
              footerPadding: 0,
              header: HeaderNotification(
                  text: "Ваш профиль", canGoBack: false),
              body: CustomScrollView(
                slivers: [SliverFillRemaining(
                  child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding),
                          child: Column(
                            children: [
                              Visibility(
                                
                                  visible: (profile != null &&
                                      profile!.personal != "")
                                      ? true
                                      : false,
                                  child: Container(
                                      margin: EdgeInsets.only(top: 12),
                                      child: Material(
                                        color: colorMain,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: InkWell(
                                          onTap: () {
                                            bottomNavigationSelectService!
                                                .canLogin = true;
                                            bottomNavigationSelectService!
                                                .function!
                                                .call(TabItem.contracts);
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  defaultSidePadding,
                                                  14,
                                                  defaultSidePadding,
                                                  14),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                          profileService!
                                                              .userType ==
                                                              "fl"
                                                              ? "Лицевой счёт"
                                                              : "Договор",
                                                          style:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                              15)),
                                                      isLoading == true ? Skeleton() :
                                                      Text(
                                                          (profile != null &&
                                                              profile!.personal !=
                                                                  null &&
                                                              profile!.personal !=
                                                                  "")
                                                              ? profile!
                                                              .personal!
                                                              : "Заключите договор",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: size))
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                        color: lsButtonColor,
                                                        shape:
                                                        BoxShape.circle),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsets.fromLTRB(
                                                          13, 9, 11, 9),
                                                      child: SvgPicture.asset(
                                                        "assets/ls-right-arrow.svg",
                                                        color: colorMain,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ))),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 14, 0, 14),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFFD4D9E6),
                                        spreadRadius: 5,
                                        blurRadius: 16,
                                        offset: Offset(0, 8),
                                      )
                                    ]),
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        defaultSidePadding,
                                        14,
                                        defaultSidePadding,
                                        14),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                                margin:
                                                const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text("ИНН",
                                                        style: TextStyle(
                                                            color:
                                                            profileLabelColor,
                                                            fontSize: 15)),
                                                    isLoading == true ? Skeleton() :
                                                    Text(
                                                        (profile != null &&
                                                            profile!.inn !=
                                                                null)
                                                            ? profile!.inn!
                                                            : "",
                                                        style:
                                                        TextStyle(
                                                          color: Colors.black,
                                                          fontSize: size,
                                                        ))
                                                  ],
                                                )),
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 16),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(profileService!
                                                    .userType ==
                                                    "fl" ? "Лицевой счет" : "Договор",
                                                    style: TextStyle(
                                                      color:
                                                      profileLabelColor,
                                                      fontSize: 15,
                                                    )),
                                                isLoading == true ? Skeleton() :
                                                profile!.personal != "" ? Text(profile!.personal ?? "", style: TextStyle(fontSize: size),) : InkWell(onTap: (){}, child: Text("Вам нужно заключить договор", style: TextStyle(color: colorMain, fontSize: size)))
                                              ],
                                            )),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 0, 16),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(emailProfile,
                                                    style: TextStyle(
                                                        color:
                                                        profileLabelColor,
                                                        fontSize: 15)),
                                                isLoading == true ? Skeleton() :
                                                Text(
                                                    (profile != null &&
                                                        profile!.email !=
                                                            null)
                                                        ? profile!.email!
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: size))
                                              ],
                                            )),
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 16),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(address,
                                                    style: TextStyle(
                                                        color:
                                                        profileLabelColor,
                                                        fontSize: 15)),
                                                isLoading == true ? Skeleton() :
                                                Text(
                                                    (profile != null &&
                                                        profile!.address !=
                                                            "")
                                                        ? profile!.address!
                                                        : "Отсутствует",
                                                    style: TextStyle(
                                                        color: profile!.address != ""  ?Colors.black : profileLabelColor,
                                                        fontSize: size))
                                              ],
                                            ))
                                      ],
                                    )),
                                  
                                
                              ),
                              //const Spacer(),

                            ],
                          )
                      )

                    ],
                  )
              ),
                )],
              ), footer: Visibility(
              visible: (profile != null &&
                  profile!.personal != null)
                  ? true
                  : false,
              child: Container(
                  width: bottomButtonWidth,
                  margin: EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding, bottom: 22),
                  height: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SendTestimony(
                                        personal: profile!
                                            .personal ??
                                            "")));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorGray,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  8))),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration:
                            const BoxDecoration(
                                color: Colors.white,
                                shape:
                                BoxShape.circle),
                            child: Padding(
                              padding:
                              const EdgeInsets.all(
                                  10),
                              child: SvgPicture.asset(
                                'assets/meters-data.svg',
                                color: colorGray,
                              ),
                            ),
                            //margin: EdeInsets.fromLTRB(0, 0, 20, 0),
                          ),
                          Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  "Передать показания",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size,
                                      fontFamily:
                                      'Bubicon-Medium'),
                                ))),
                          Container(
                            //margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: meterDataColor,
                                shape: BoxShape.circle),
                            child: Padding(
                              padding:
                              EdgeInsets.fromLTRB(
                                  13, 9, 11, 9),
                              child: SvgPicture.asset(
                                "assets/ls-right-arrow.svg",
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )))), onRefrash: _refrash);
        });
  }

  _listener(BuildContext context, AuthState state) {
   isLoading = state.loading!;
    if (state.loading == true) {
      return;
    }

    if (state.profile != null) {
      profile = state.profile!;
      user_inn = state.profile!.personal;
      profileService!.accountNumber = state.profile!.personal;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileService ??= DependencyProvider.of(context)!.profileService;
    bottomNavigationSelectService ??=
        DependencyProvider.of(context)!.bottomNavigationSelectService;
    authBloc!.loginWithCookies();
  }
}
