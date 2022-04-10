import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

class ClaimElement extends StatefulWidget{

  final String claimName;
  final String claimNumber;
  final DateTime date;

  ClaimElement({Key? key, required this.claimName, required this.claimNumber, required this.date}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClaimElement();

}

class _ClaimElement extends State<ClaimElement>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Название заявления", style: TextStyle(
                color: whiteLabelColor,
                fontSize: 15
              )),
              Text(widget.claimName)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Номер заявления", style: TextStyle(
                  color: whiteLabelColor,
                  fontSize: 15
              )),
              Text(widget.claimNumber)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Дата", style: TextStyle(
                  color: whiteLabelColor,
                  fontSize: 15
              )),
              Text(widget.date.toString())
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Статус заявления", style: TextStyle(
                  color: whiteLabelColor,
                  fontSize: 15
              )),
              Text(widget.date.toString())
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Статус оплаты", style: TextStyle(
                  color: whiteLabelColor,
                  fontSize: 15
              )),
              Text(widget.date.toString())
            ],
          ),
          ElevatedButton(onPressed: (){},
              child: const Text("Скачать заявление"))
        ],
      )
    );
  }
}