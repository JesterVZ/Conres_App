import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/contracts/contracts.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header-notification.dart';
import '../icons.dart';
import '../model/profile.dart';
import '../testimony/link-pu.dart';
import '../testimony/send-testimony.dart';

class ProfilePageTest extends StatefulWidget {
  ProfilePageTest({Key? key, this.profile, this.loginData}) : super(key: key);
  Profile? profile;
  final List<dynamic>? loginData;
  Widget content = Scaffold(
      body: Center(
          child: Container(
    width: 50,
    height: 50,
    child: Image.asset('assets/loading.gif'),
  )));

  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePageTest> {
  AuthBloc? authBloc;
  ProfileBloc? profileBloc;

  Future<void> _refrash() async {
    print("refrash");
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return widget.content;
        });
  }

  _listener(BuildContext context, AuthState state) {
    if (state.loading == true) {
      return;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    if (widget.profile != null) {
      widget.content = Scaffold(
          body: Container(
              child: RefreshIndicator(
        onRefresh: _refrash,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      defaultSidePadding, 59, defaultSidePadding, 0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          HeaderNotification(text: profile),
                          Visibility(
                              visible: widget.profile!.personal != null
                                  ? true
                                  : false,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Contracts()));
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  decoration: BoxDecoration(
                                      color: colorMain,
                                      borderRadius: BorderRadius.circular(10)),
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
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Текущий Лицевой счёт",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15)),
                                              Text(widget.profile!.personal!,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18))
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                                color: lsButtonColor,
                                                shape: BoxShape.circle),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
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
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(defaultSidePadding,
                                    14, defaultSidePadding, 14),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(inn,
                                                    style: TextStyle(
                                                        color:
                                                            profileLabelColor,
                                                        fontSize: 15)),
                                                Text(widget.profile!.inn!,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ))
                                              ],
                                            )),
                                        Spacer(),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colorGray,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                                "assets/profile-ls.svg"),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(gpINN,
                                                style: TextStyle(
                                                  color: profileLabelColor,
                                                  fontSize: 15,
                                                )),
                                            Text(
                                                widget.profile!.personalGP ==
                                                        null
                                                    ? needDogovor
                                                    : widget
                                                        .profile!.personalGP!,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18))
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(emailProfile,
                                                style: TextStyle(
                                                    color: profileLabelColor,
                                                    fontSize: 15)),
                                            Text(widget.profile!.email!,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18))
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
                                                    color: profileLabelColor,
                                                    fontSize: 15)),
                                            Text(widget.profile!.address!,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18))
                                          ],
                                        ))
                                  ],
                                )),
                          ),
                        ],
                      ),
                      Visibility(
                          visible:
                              widget.profile!.personal != null ? true : false,
                          child: Positioned(
                              bottom: 24,
                              child: Container(
                                  width: MediaQuery.of(context).size.width - 35,
                                  height: 70,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SendTestimony(
                                                        personal: widget
                                                            .profile!
                                                            .personal)));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: colorGray,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: SvgPicture.asset(
                                                'assets/meters-data.svg',
                                                color: colorGray,
                                              ),
                                            ),
                                            //margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                          ),
                                          Spacer(),
                                          const Text(
                                            "Передать показания",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: 'Bubicon-Medium'),
                                          ),
                                          Spacer(),
                                          Container(
                                            //margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                                color: meterDataColor,
                                                shape: BoxShape.circle),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  13, 9, 11, 9),
                                              child: SvgPicture.asset(
                                                "assets/ls-right-arrow.svg",
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      )))))
                    ],
                  )),
            )
          ],
        ),
      )));
    }
  }
}
