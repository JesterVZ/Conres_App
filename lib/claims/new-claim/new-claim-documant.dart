import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/material.dart';
import '../../consts.dart';
import '../../elements/claims/claim-type-element.dart';
import '../../elements/header/header.dart';

class NewClaimDicument extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewClaimDicument();
}

class _NewClaimDicument extends State<NewClaimDicument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
            padding: EdgeInsets.fromLTRB(
                defaultSidePadding, 52, defaultSidePadding, 0),
            child: Column(children: [
              Container(
                child: HeaderNotification(text: "Заявления"),
              ),
              ClaimTypeELement(text: "Заявление на технологическое присоединение к электрическим сетям."),
              ClaimTypeELement(text: "Заявление о необходимости снятия показаний существующего прибора учета."),
              ClaimTypeELement(text: "Заявление на осуществление допуска в эксплуатацию прибора учета."),
            ]))
          ]),
        ));
  }
}
