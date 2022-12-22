import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';
import '../testimony/edit-pu.dart';
/* 
pu-info-show.dart
Информаця о ПУ

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class PuInfoShow extends StatelessWidget {
  const PuInfoShow(
      {Key? key,
      required this.numberPu,
      required this.point,
      required this.address,
      required this.tariff,
      required this.type,
      required this.countInTariff,
      required this.factor,
      required this.nameTu,
      required this.name})
      : super(key: key);
  final String name;
  final String numberPu;
  final int point;
  final String address;
  final String tariff;
  final String type;
  final String countInTariff;
  final double factor;
  final String nameTu;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderProfileColor)),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 26),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(name, style: buttonTextStyle),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: yellowColor,
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          width: 160,
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                            child: Text("Проходит проверку",
                                style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                          )
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: whiteBlueColor),
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset('assets/meters-data.svg')))
                  ],
                )),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 33),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("№ прибора учёта:", style: puTextStyle),
                          Text(
                            numberPu.toString(),
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("№ точка учёта:", style: puTextStyle),
                        Text(point.toString(),
                            style: const TextStyle(fontSize: 16))
                      ],
                    )
                  ],
                )),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Адрес ТУ:", style: puTextStyle),
                  Text(
                    address,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  direction: Axis.vertical,
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 33),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Тарифная зона ПУ:", style: puTextStyle),
                            Text(
                              tariff,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Тип ПУ:", style: puTextStyle),
                        Text(type, style: const TextStyle(fontSize: 16))
                      ],
                    )
                  ],
                )),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 148,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text("Кол-во показаний в тарифе:",
                                    style: puTextStyle),
                              ),
                            ],
                          )),
                      Text(
                        countInTariff,
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 140,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                child: Text("Множитель показаний:",
                                    style: puTextStyle),
                              ),
                            ],
                          )),
                      Text(factor.toString(),
                          style: const TextStyle(fontSize: 16))
                    ],
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 140,
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              child:
                                  Text("Наименование ТУ:", style: puTextStyle),
                            ),
                          ],
                        )),
                    Text(nameTu, style: const TextStyle(fontSize: 16))
                  ],
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              child: ElevatedButton(
                child: Text(editPU, style: buttonTextStyle),
                style: ElevatedButton.styleFrom(
                    primary: colorGray, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                )),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:  (context) => EditPU()));
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
