import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/claims/new-claim/new-claim-step-1.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/material.dart';
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
                        text:
                            "Заявление на технологическое присоединение к электрическим сетям.",
                        page: NewClaimStep7()),
                    ClaimTypeELement(
                        text:
                            "Заявление о необходимости снятия показаний существующего прибора учета.",
                        page: BaseClaimStep1()),
                    ClaimTypeELement(
                        text:
                            "Заявление на осуществление допуска в эксплуатацию прибора учета.",
                        page: BaseClaimStep1()),
                    ClaimTypeELement(
                        text:
                            "Заявление на оборудование точки поставки приборами учета.",
                        page: BaseClaimStep1()),
                    ClaimTypeELement(
                        text:
                            "Заявление на установку, замену и (или) эксплуатацию приборов учета.",
                        page: BaseClaimStep1()),
                  ],
                ))),
        onRefrash: _refrash);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
