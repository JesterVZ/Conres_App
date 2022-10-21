import 'package:conres_app/model/TU.dart';
import 'package:flutter/cupertino.dart';

import '../../consts.dart';
import '../full-profile/ExpansionTileElement.dart';

class TuElement extends StatefulWidget {
  final TuModel? currentTu;

  TuElement({required this.currentTu});
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
                      //PayStatusElement(status: widget.currentClaim.status_pay!),
                    ],
                  ),
                ),
                Text("Документы",
                    style: TextStyle(color: colorGrayClaim, fontSize: 15)),
              ],
            )));
  }
}
