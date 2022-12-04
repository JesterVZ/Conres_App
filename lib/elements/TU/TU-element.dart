import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/model/TU.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';
import '../../testimony/pu-info.dart';
import '../full-profile/ExpansionTileElement.dart';
import 'edit-tu-dialog.dart';

class TuElement extends StatefulWidget {
  final TuModel? currentTu;

  TuElement({required this.currentTu});
  @override
  State<StatefulWidget> createState() => _TuElement();
}

class _TuElement extends State<TuElement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: defaultSidePadding, right: defaultSidePadding),
        child: Container(
            margin: const EdgeInsets.only(top: 14, bottom: 14),
            child: ExpansionTileElement(
                tileText: const Text("Подробнее"),
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.fromLTRB(11, 6, 11, 6),
                          decoration: BoxDecoration(
                              color: widget.currentTu!.status == "0"
                                  ? redColor
                                  : widget.currentTu!.status == "1"
                                      ? yellowColor
                                      : greenColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            widget.currentTu!.status == "0"
                                ? "Заявка на привязку ПУ отклонена"
                                : widget.currentTu!.status == "1"
                                    ? "Проходит проверку"
                                    : "Активный",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                          visible:
                              widget.currentTu!.status == "0" ? true : false,
                          child: Material(
                              child: InkWell(
                            onTap: () {
                              //widget.remove.call(widget.objectPuModel);
                            },
                            child: SvgPicture.asset(
                              'assets/remove-file.svg',
                              color: colorGrayClaim,
                            ),
                          )),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("№ точки учёта:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentTu!.number!,
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),

                          //StatusElement(status: widget.currentClaim.status!),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("Наименование ТУ:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentTu!.name!,
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),

                          //StatusElement(status: widget.currentClaim.status!),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("Адрес ТУ:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentTu!.address!,
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),

                          //StatusElement(status: widget.currentClaim.status!),
                        ],
                      ),
                    ),
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: EdgeInsets.only(bottom: 12, top: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            /*
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              EditTuDialog(title: "Редактировать ТУ"));*/
                          },
                          child: const Text("Редактировать",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: EdgeInsets.only(bottom: 12, top: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PuFullInfo()));
                          },
                          child: Text("Подробнее",
                              style: TextStyle(color: colorMain, fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: messageColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                  ],
                ))));
  }
}
