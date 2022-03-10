import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';
import '../model/meter.dart';

class Testimony extends StatelessWidget {
  final Meter meter;

  const Testimony(this.meter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 21),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: borderProfileColor),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: Padding(
                  padding: EdgeInsets.all(17),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(meter.name!, style: TextStyle(fontSize: 18)),
                          Text(meter.tu_name!,
                              style: TextStyle(
                                  fontSize: 15, color: profileLabelColor))
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: colorMain, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            'assets/meters-data.svg',
                            color: Colors.white,
                          ),
                        ),
                        //margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      )
                    ],
                  ))),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: borderProfileColor),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Padding(
                  padding: EdgeInsets.all(17),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Предыдущие показания'),
                          Text(meter.lastReadings != null ? meter.lastReadings!.reading.toString() : "0", style: TextStyle(fontSize: 18, color: colorMain),)
                        ],
                      ),
                      const Spacer(),
                      Container(
                          width: 91,
                          height: 45,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "0000",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: inputBorder))),
                          ))
                    ],
                  )))
        ],
      )
    );

  }
}
