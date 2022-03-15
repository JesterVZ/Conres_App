import 'package:conres_app/elements/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc-screen.dart';
import '../elements/header-notification.dart';
import '../icons.dart';
import '../model/profile.dart';
import '../testimony/link-pu.dart';
import '../testimony/send-testimony.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, this.profile, this.loginData}) : super(key: key);

  Profile? profile;
  Widget content = Scaffold(
    body: Center(
        child: Container(
          width: 50,
          height: 50,
          child: Image.asset('assets/loading.gif'),
        )
    )
  );
  final List<dynamic>? loginData;
  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  AuthBloc? authBloc;

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
    if(state.loading == true){
      return;
    }

    if(state.profile != null){
      setState(() {
        widget.profile = state.profile;
        widget.content = Scaffold(
          body: Padding(
              padding: const EdgeInsets.fromLTRB(17, 59, 17, 0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      HeaderNotification(profile),
                      Visibility(
                          visible: widget.profile!.personal != null ? true : false,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                            decoration: BoxDecoration(
                                color: profileColor,
                                border: Border.all(color: borderProfileColor),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(ls,
                                            style: TextStyle(
                                                color: profileLabelColor,
                                                fontSize: 15)),
                                        Text(widget.profile!.personal!,
                                            style: const TextStyle(
                                                color: Colors.black, fontSize: 18))
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                          color: lsButtonColor,
                                          shape: BoxShape.circle
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(13, 9, 11, 9),
                                        child: SvgPicture.asset("assets/ls-right-arrow.svg", color: colorMain,),
                                      ),
                                    )
                                  ],
                                )),
                          )
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: profileColor,
                            border: Border.all(color: borderProfileColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(inn,
                                                style: TextStyle(

                                                    color: profileLabelColor,
                                                    fontSize: 15)),
                                            Text(widget.profile!.inn,
                                                style: const TextStyle(
                                                  color: Colors.black, fontSize: 18, ))
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
                                        child: SvgPicture.asset("assets/profile-ls.svg"),
                                      ),
                                    )
                                  ],
                                ),

                                Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(gpINN,
                                            style: TextStyle(
                                              color: profileLabelColor,
                                              fontSize: 15,
                                            )),
                                        Text(widget.profile!.personalGP == null ? needDogovor : widget.profile!.personalGP!,
                                            style: const TextStyle(
                                                color: Colors.black, fontSize: 18))
                                      ],
                                    )),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(emailProfile,
                                            style: TextStyle(
                                                color: profileLabelColor,
                                                fontSize: 15)),
                                        Text(widget.profile!.email,
                                            style: const TextStyle(
                                                color: Colors.black, fontSize: 18))
                                      ],
                                    )),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(address,
                                            style: TextStyle(
                                                color: profileLabelColor,
                                                fontSize: 15)),
                                        Text(widget.profile!.address,
                                            style: const TextStyle(
                                                color: Colors.black, fontSize: 18))
                                      ],
                                    ))
                              ],
                            )),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: widget.profile!.personal != null ? true : false,
                      child: Positioned(
                          bottom: 24,
                          child: Container(
                              width: MediaQuery.of(context).size.width - 35,
                              height: 70,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SendTestimony()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: colorGray, shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                  )),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SvgPicture.asset('assets/meters-data.svg', color: colorGray,),
                                        ),
                                        //margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                      ),
                                      Spacer(),
                                      const Text(
                                        "Передать показания",
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Bubicon-Medium'),
                                      ),
                                      Spacer(),
                                      Container(
                                        //margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            color: meterDataColor,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(13, 9, 11, 9),
                                          child: SvgPicture.asset("assets/ls-right-arrow.svg", color: Colors.white,),
                                        ),
                                      )
                                    ],
                                  )))))

                ],
              )),
        );
      });
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    if(widget.profile != null){
      widget.content = Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(17, 59, 17, 0),
            child: Stack(
              children: [
                Column(
                  children: [
                    HeaderNotification(profile),
                    Visibility(
                        visible: widget.profile!.personal != null ? true : false,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          decoration: BoxDecoration(
                              color: profileColor,
                              border: Border.all(color: borderProfileColor),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(ls,
                                          style: TextStyle(
                                              color: profileLabelColor,
                                              fontSize: 15)),
                                      Text(widget.profile!.personal!,
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 18))
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        color: lsButtonColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(13, 9, 11, 9),
                                      child: SvgPicture.asset("assets/ls-right-arrow.svg", color: colorMain,),
                                    ),
                                  )
                                ],
                              )),
                        )
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: profileColor,
                          border: Border.all(color: borderProfileColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(inn,
                                              style: TextStyle(

                                                  color: profileLabelColor,
                                                  fontSize: 15)),
                                          Text(widget.profile!.inn,
                                              style: const TextStyle(
                                                color: Colors.black, fontSize: 18, ))
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
                                      child: SvgPicture.asset("assets/profile-ls.svg"),
                                    ),
                                  )
                                ],
                              ),

                              Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(gpINN,
                                          style: TextStyle(
                                            color: profileLabelColor,
                                            fontSize: 15,
                                          )),
                                      Text(widget.profile!.personalGP == null ? needDogovor : widget.profile!.personalGP!,
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 18))
                                    ],
                                  )),
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(emailProfile,
                                          style: TextStyle(
                                              color: profileLabelColor,
                                              fontSize: 15)),
                                      Text(widget.profile!.email,
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 18))
                                    ],
                                  )),
                              Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(address,
                                          style: TextStyle(
                                              color: profileLabelColor,
                                              fontSize: 15)),
                                      Text(widget.profile!.address,
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 18))
                                    ],
                                  ))
                            ],
                          )),
                    ),
                  ],
                ),
                Visibility(
                    visible: widget.profile!.personal != null ? true : false,
                    child: Positioned(
                        bottom: 24,
                        child: Container(
                            width: MediaQuery.of(context).size.width - 35,
                            height: 70,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SendTestimony()));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: colorGray, shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                )),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SvgPicture.asset('assets/meters-data.svg', color: colorGray,),
                                      ),
                                      //margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    ),
                                    Spacer(),
                                    const Text(
                                      "Передать показания",
                                      style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Bubicon-Medium'),
                                    ),
                                    Spacer(),
                                    Container(
                                      //margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                          color: meterDataColor,
                                          shape: BoxShape.circle
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(13, 9, 11, 9),
                                        child: SvgPicture.asset("assets/ls-right-arrow.svg", color: Colors.white,),
                                      ),
                                    )
                                  ],
                                )))))

              ],
            )),
      );
    }
    if(widget.loginData != null){
      authBloc!.login(widget.loginData![0], widget.loginData![1], widget.loginData![2]);
    }
  }

}
