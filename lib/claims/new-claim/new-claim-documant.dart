import 'package:conres_app/Services/main-claim-send-service.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/claims/new-claim/new-claim-step-1.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/material.dart';
import '../../DI/dependency-provider.dart';
import '../../consts.dart';
import '../../elements/claims/claim-type-element.dart';
import '../../elements/header/header.dart';
import 'base-claim/base-claim-step-1.dart';
import 'new-claim-step-7.dart';

class NewClaimDicument extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewClaimDicument();
}

class _NewClaimDicument extends State<NewClaimDicument> {
  MainClaimSendService? mainClaimSendService;

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
                          mainClaimSendService!.claim_template =
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
                          mainClaimSendService!.claim_template =
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
                          mainClaimSendService!.claim_template =
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
                          mainClaimSendService!.claim_template =
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
    super.didChangeDependencies();
  }
}
