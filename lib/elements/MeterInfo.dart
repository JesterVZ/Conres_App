import 'package:conres_app/elements/pu-info-show.dart';
import 'package:flutter/cupertino.dart';

import '../model/meter.dart';
/* 
MeterInfo.dart
Инфрмация о ПУ

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class MeterInfo extends StatelessWidget{
  Meter meter;

  MeterInfo(this.meter);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      child: PuInfoShow(
        numberPu: meter.pu_number!,
        point: 3235,
        address: "meter.address!",
        tariff: "Двухфазный",
        type: "Электроэнергия",
        countInTariff: "2 ( День, Ночь )",
        factor: double.parse(meter.measure_multipler!),
        name: meter.name!,
        nameTu: meter.name!,
      ),
    );
  }
}