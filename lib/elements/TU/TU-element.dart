import 'package:conres_app/model/TU.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import '../full-profile/ExpansionTileElement.dart';

class TuElement extends StatefulWidget {
  final TuModel? currentTu;
  VoidCallback editFunc;

  TuElement({required this.currentTu, required this.editFunc});
  @override
  State<StatefulWidget> createState() => _TuElement();
}

class _TuElement extends State<TuElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 14, bottom: 14),
        child: ExpansionTileElement(
            tileText: const Text("Подробнее"),
            header: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                        fontSize: 15, color: colorGrayClaim))),
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
                                        fontSize: 15, color: colorGrayClaim))),
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
                                        fontSize: 15, color: colorGrayClaim))),
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
                        widget.editFunc.call();
                      },
                      child: Text("Редактировать",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorGray,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
              ],
            )));
  }
}
