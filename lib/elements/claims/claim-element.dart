import 'package:accordion/accordion_section.dart';
import 'package:conres_app/elements/claims/status-element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import '../../model/claim.dart';

class ClaimElement extends StatefulWidget {
  final Claim currentClaim;
  ClaimElement({Key? key, required this.currentClaim}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ClaimElement();
}

class _ClaimElement extends State<ClaimElement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding),
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 19, 18, 19),
        margin: EdgeInsets.only(bottom: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: Text("Название заявления",
                          style:
                              TextStyle(fontSize: 15, color: colorGrayClaim))),
                  Text(widget.currentClaim.name!,
                      style: const TextStyle(fontSize: 18))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 22),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: Text("Номер заявления",
                                style: TextStyle(
                                    fontSize: 15, color: colorGrayClaim))),
                        Text(widget.currentClaim.claim_id!,
                            style: const TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          child: Text("Дата",
                              style: TextStyle(
                                  fontSize: 15, color: colorGrayClaim))),
                      Text(widget.currentClaim.date!,
                          style: const TextStyle(fontSize: 18))
                    ],
                  )
                ],
              ),
            ),
            StatusElement(status: widget.currentClaim.status_name!)
          ],
        ),
      ),
    );
  }
}
