import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';
import '../../notification/notification-list.dart';


class HeaderNotification extends StatelessWidget{
  String text = "";
  bool? canGoBack = false;
  HeaderNotification({required this.text, this.canGoBack});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: canGoBack != null ? canGoBack! : false,
          child: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: Image.asset('assets/back-arrow.png'),
          ),
        )),
        Text(text, style: profileHeaderTextStyle),
        const Spacer(),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:  (context) =>  NotificationListPage()));
          },
          child: SvgPicture.asset("assets/notification.svg"),
        )
      ],
    );
  }
}