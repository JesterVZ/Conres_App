import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../elements/bloc/bloc-screen.dart';

class FullProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FullProfile();
}

class _FullProfile extends State<FullProfile>{
  AuthBloc? authBloc;
  ProfileBloc? profileBloc;
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: _listener,
      builder: (context, state){
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: HeaderNotification(text: "Основная информация"),
              ),
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 106,
                      height: 77,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorMain
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                          width: 32,
                          height: 32,
                          margin: EdgeInsets.only(bottom: 7),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1)
                          ),
                          child: SvgPicture.asset('assets/main.svg', color: Colors.white),
                        ),
                        Text("Общие", style: TextStyle(
                          color: Colors.white
                        ))
                      ]),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 106,
                      height: 77,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorMain
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                          width: 32,
                          height: 32,
                          margin: EdgeInsets.only(bottom: 7),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1)
                          ),
                          child: SvgPicture.asset('assets/contacts.svg', color: Colors.white,),
                        ),
                        Text("Контакты", style: TextStyle(
                          color: Colors.white
                        ))
                      ]),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 106,
                      height: 77,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorMain
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                          width: 32,
                          height: 32,
                          margin: EdgeInsets.only(bottom: 7),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1)
                          ),
                          child: SvgPicture.asset('assets/confidant.svg', color: Colors.white),
                        ),
                        Text("Дов. лицо", style: TextStyle(
                          color: Colors.white
                        ))
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
          )
        );
      });
  }
  _listener(BuildContext context, ProfileState state) {

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    authBloc ??= DependencyProvider.of(context)!.authBloc;
  }
}