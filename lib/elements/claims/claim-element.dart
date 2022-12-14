import 'package:accordion/accordion_section.dart';
import 'package:conres_app/elements/claims/status-element.dart';
import 'package:conres_app/enums/chat-types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../chats/messages.dart';
import '../../consts.dart';
import '../../model/claim.dart';
import '../full-profile/ExpansionTileElement.dart';

class ClaimElement extends StatefulWidget {
  final Claim currentClaim;
  ValueChanged<Claim> downloadFunction;
  Function? mainListener;
  ClaimElement(
      {Key? key,
      required this.currentClaim,
      required this.downloadFunction,
      required this.mainListener})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ClaimElement();
}

class _ClaimElement extends State<ClaimElement> {
  @override
  Widget build(BuildContext context) {
    double bottomButtonWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(
            left: defaultSidePadding, right: defaultSidePadding),
        child: Container(
            margin: const EdgeInsets.only(top: 14, bottom: 14),
            child: ExpansionTileElement(
                tileText: const Text("Подробнее"),
                header: Column(
                  children: [
                    Column(
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
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: colorGrayClaim))),
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
                                        margin:
                                            const EdgeInsets.only(bottom: 3),
                                        child: Text("Номер заявления",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: colorGrayClaim))),
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
                                              fontSize: 15,
                                              color: colorGrayClaim))),
                                  Text(widget.currentClaim.date!,
                                      style: const TextStyle(fontSize: 18))
                                ],
                              )
                            ],
                          ),
                        ),
                        StatusElement(status: widget.currentClaim.status!),
                      ],
                    )
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Text("Статус оплаты",
                                  style: TextStyle(
                                      fontSize: 15, color: colorGrayClaim))),
                          PayStatusElement(
                              status: widget.currentClaim.status_pay!),
                        ],
                      ),
                    ),
                    Text("Документы",
                        style: TextStyle(color: colorGrayClaim, fontSize: 15)),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: EdgeInsets.only(bottom: 12, top: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.downloadFunction.call(widget.currentClaim);
                          },
                          child: Text("Скачать заявление",
                              style:
                                  TextStyle(color: Colors.white, fontSize: bottomButtonWidth * 0.05)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MessagesPage(
                                        mainListener: widget.mainListener,
                                        genericId:
                                            widget.currentClaim.claim_id!,
                                        type: ChatTypes.Claim,
                                        page: '1',
                                        statusName:
                                            widget.currentClaim.status ?? "")));
                          },
                          child: Text("Внести изменения",
                              style: TextStyle(color: colorMain, fontSize: bottomButtonWidth * 0.05)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: messageColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                  ],
                ))));
  }
}
