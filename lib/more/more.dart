import 'package:conres_app/claims/new-claim/new-claim-documant.dart';
import 'package:conres_app/claims/new-claim/new-claim-step-6.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../Services/main-claim-send-service.dart';
import '../Services/profile-service.dart';
import '../UI/default-button.dart';
import '../claims/new-claim/new-claim-step-1.dart';
import '../consts.dart';
import '../elements/header/header-notification.dart';
import '../elements/header/header.dart';
import '../profile/full-profile-page.dart';
import '../testimony/info-pu.dart';
import '../testimony/objects-pu.dart';

class MoreScreen extends StatefulWidget {
  final VoidCallback logout;
  MoreScreen({required this.logout});
  @override
  State<StatefulWidget> createState() => _MoreScreen();
}

class _MoreScreen extends State<MoreScreen> {
  MainClaimSendService? mainClaimSendService;
  ProfileService? profileService;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 52),
            padding: EdgeInsets.only(
                left: defaultSidePadding,
                right: defaultSidePadding,
                bottom: 12),
            child: HeaderNotification(
              text: "Ещё",
            )),
        Container(
          child: Image.network(
              "https://rep.dev.conres.ru/files_rso/107/settings/logo_107.png"),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultButton(
                isGetPadding: true,
                text: "Информация о ПУ",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ObjectsPU()));
                },
                margin: EdgeInsets.only(bottom: 12),
              ),
              DefaultButton(
                  isGetPadding: true,
                  text: "Профиль",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FullProfile()));
                  },
                  margin: EdgeInsets.only(bottom: 12)),
              DefaultButton(
                  isGetPadding: true,
                  text: "Заявление на тех. присоединение",
                  onPressed: () {
                    mainClaimSendService!.claim_template =
                        "claims/claim_techconn";
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewClaimStep1()));
                  },
                  margin: EdgeInsets.only(bottom: 12)),
              DefaultButton(
                isGetPadding: true,
                text: "Выход",
                onPressed: () {
                  widget.logout.call();
                },
              )
            ],
          ),
        )),
      ],
    ));
  }

  @override
  void didChangeDependencies() {
    mainClaimSendService ??=
        DependencyProvider.of(context)!.mainClaimSendService;
    profileService ??= DependencyProvider.of(context)!.profileService;
    mainClaimSendService!.claim_type = profileService!.userType;
    super.didChangeDependencies();
  }
}
