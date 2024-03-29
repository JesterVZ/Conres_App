import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/model/TU.dart';
import 'package:conres_app/model/meter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';
import '../../testimony/tu-info.dart';
import '../TU/edit-tu.dart';
import '../full-profile/ExpansionTileElement.dart';
/* 
meter.dart
Виджет счетчика

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class MeterElement extends StatefulWidget {
  final Meter? currentMeter;
  final TuModel? currentTu;
  ValueChanged<Meter> remove;
  VoidCallback? refrash;
  Function edit;

  List<TuModel> TuPoints;

  MeterElement(
      {required this.currentMeter,
      required this.remove,
      required this.currentTu,
      required this.edit,
      required this.TuPoints,
      required this.refrash});
  @override
  State<StatefulWidget> createState() => _MeterElement();
}

class _MeterElement extends State<MeterElement> {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ExpansionTileElementState> _key = GlobalKey();
    double textSize = MediaQuery.of(context).size.width * 0.04;
    return Padding(
        padding: EdgeInsets.only(
            left: defaultSidePadding, right: defaultSidePadding),
        child: Container(
            margin: const EdgeInsets.only(top: 14, bottom: 14),
            child: ExpansionTileElement(
              key: _key,
                tileText: const Text("Параметры"),
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.fromLTRB(11, 6, 11, 6),
                          decoration: BoxDecoration(
                              color: (widget.currentMeter!.status == "0")
                                  ? redColor
                                  : (widget.currentMeter!.status == "1" || widget.currentMeter!.status == "3" || (widget.currentMeter!.status == "3" && widget.currentMeter!.comments != null))
                                      ? yellowColor
                                      : greenColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            widget.currentMeter!.status == "0" ? "Заявка на привязку ПУ отклонена"
                                : widget.currentMeter!.status == "1" ? "Проходит проверку на добавление"
                                : widget.currentMeter!.status == "2" ? "Активный" 
                                : widget.currentMeter!.status == "3" ? "Проходит проверку на изменение" : (widget.currentMeter!.status == "3" && widget.currentMeter!.comments != null) ? "Заявка на изменение отклонена": "",
                            style: TextStyle(color: Colors.white, fontSize: textSize),
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                          visible:
                              (widget.currentMeter!.status == "0") ? true : false,
                          child: Material(
                              child: InkWell(
                            onTap: () {
                              widget.remove.call(widget.currentMeter!);
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
                        child: Text(widget.currentMeter!.name!,
                            style: const TextStyle(fontSize: 18))),
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 17),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("№ прибора учёта:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentMeter!.pu_number!,
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 17),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("Тарифная зона ПУ:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentMeter!.tariff_type_id == "2" ? "Двухтарифный" : widget.currentMeter!.tariff_type_id == "3" ? "Однотарифный" : "",
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 17),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("Тип ПУ:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentMeter!.pu_type_id!,
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 17),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 3),
                                    child: Text("Множитель показаний:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorGrayClaim))),
                                Text(widget.currentMeter!.measure_multipler!,
                                    style: const TextStyle(fontSize: 18))
                              ],
                            ),
                          ),

                          //StatusElement(status: widget.currentClaim.status!),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: const EdgeInsets.only(bottom: 12, top: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPuPage(
                                          refrash: widget.refrash,
                                          TuPoints: widget.TuPoints,
                                          currentMeter: widget.currentMeter!,
                                        )));
                          },
                          child:  Text("Редактировать",
                              style:
                                  TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: const EdgeInsets.only(bottom: 12, top: 12),
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          child: Text("Cвернуть",
                              style: TextStyle(color: colorMain, fontSize: MediaQuery.of(context).size.width * 0.05)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: messageColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                  ],
                ))));
  }
}
