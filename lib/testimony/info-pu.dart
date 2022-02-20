import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../consts.dart';
import '../elements/header-notification.dart';
import '../elements/pu-info-show.dart';

class InfoPU extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _InfoPU();
}

class _InfoPU extends State<InfoPU>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(21, 58, 21, 54),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                          child: HeaderNotification(puInfo)),
                      Container(
                        margin: EdgeInsets.only(bottom: 22),
                        child: const PuInfoShow(
                          numberPu: 3235,
                          point: 3235,
                          address: "г.Пермь, Транспортная 10, кв 100 ",
                          tariff: "Двухфазный",
                          type: "Электроэнергия",
                          countInTariff: "2 ( День, Ночь )",
                          factor: 3,
                          name: "NameCounter",
                          nameTu: "3235",
                        ),
                      ),

                      const PuInfoShow(
                        numberPu: 3235,
                        point: 3235,
                        address: "г.Пермь, Транспортная 10, кв 100 ",
                        tariff: "Двухфазный",
                        type: "Электроэнергия",
                        countInTariff: "2 ( День, Ночь )",
                        factor: 3,
                        name: "NameCounter",
                        nameTu: "3235",
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          child: ElevatedButton(
                              onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder:  (context) => const RegSuccess()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    margin: EdgeInsets.only(right: 14),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: SvgPicture.asset('assets/plus.svg')
                                    )
                                  ),
                                  Text(
                                      linkNewPu,
                                    style: buttonTextStyle,
                                  )
                                ],
                              ),
                              style: ElevatedButton.styleFrom(primary: colorMain, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ))))


                    ],
                  ))

            ],
          ),
        )
    );
  }

}