import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

class TestimonyNotfound extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ]
      ),
      child: Column(children: [
        Row(children: [
          const Text("Приборы учёта", style: TextStyle(fontSize: 20)),
          const Spacer(),
          Image.asset('assets/search.png')
        ]),
        Text("По данному лицевому счёту не найдены приборы учёта, отправьте заявку на привязку ПУ и дождитесь подтверждения.", style: TextStyle(color: colorGrayClaim, fontSize: 16))
      ]),
    );
  }
}