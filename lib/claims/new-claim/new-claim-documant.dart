import 'package:conres_app/Services/main-claim-send-service.dart';
import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/claims/new-claim/new-claim-step-1.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/material.dart';
import '../../DI/dependency-provider.dart';
import '../../Services/base-claim-send-service.dart';
import '../../consts.dart';
import '../../elements/claims/claim-type-element.dart';
import '../../elements/header/header.dart';
import 'base-claim/base-claim-step-1.dart';
import 'new-claim-step-7.dart';
import 'package:intl/intl.dart';
/* 
new-claim-documant.dart
Выбор типов заявлений

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
*/
class NewClaimDicument extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewClaimDicument();
}

class _NewClaimDicument extends State<NewClaimDicument> {
  MainClaimSendService? mainClaimSendService;
  BaseClaimSendService? baseClaimSendService;
  ProfileService? profileService;

  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return MainForm(
        header: HeaderNotification(text: "Тип заявления", canGoBack: true),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    left: defaultSidePadding, right: defaultSidePadding),
                child: Column(
                  children: [
                    ClaimTypeELement(
                        func: () {
                          DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('dd.MM.yyyy').format(now);
                          mainClaimSendService!.claim_name = "1";
                          mainClaimSendService!.claim_type_id = "1";
                          mainClaimSendService!.field_content_date =
                              formattedDate;
                          mainClaimSendService!.claim_template =
                              "claims/claim_techconn";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewClaimStep1()));
                        },
                        text:
                            "Заявление на технологическое присоединение к электрическим сетям."),
                    ClaimTypeELement(
                        func: () {
                          baseClaimSendService!.claim_template =
                              "claims/claim_1";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BaseClaimStep1()));
                        },
                        text:
                            "Заявление о необходимости снятия показаний существующего прибора учета."),
                    ClaimTypeELement(
                        func: () {
                          baseClaimSendService!.claim_template =
                              "claims/claim_2";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BaseClaimStep1()));
                        },
                        text:
                            "Заявление на осуществление допуска в эксплуатацию прибора учета."),
                    ClaimTypeELement(
                        func: () {
                          baseClaimSendService!.claim_template =
                              "claims/claim_3";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BaseClaimStep1()));
                        },
                        text:
                            "Заявление на оборудование точки поставки приборами учета."),
                    ClaimTypeELement(
                        func: () {
                          baseClaimSendService!.claim_template =
                              "claims/claim_4";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BaseClaimStep1()));
                        },
                        text:
                            "Заявление на установку, замену и (или) эксплуатацию приборов учета."),
                  ],
                ))),
        onRefrash: _refrash);
  }

  @override
  void didChangeDependencies() {
    mainClaimSendService ??=
        DependencyProvider.of(context)!.mainClaimSendService;
    baseClaimSendService ??=
        DependencyProvider.of(context)!.baseClaimSendService;
    profileService ??= DependencyProvider.of(context)!.profileService;
    mainClaimSendService!.claim_type = profileService!.userType;
    baseClaimSendService!.claim_type = profileService!.userType;
    super.didChangeDependencies();
  }
}
