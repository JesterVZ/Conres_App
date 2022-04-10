import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';
import '../../notification/notification-list.dart';


class HeaderNotification extends StatelessWidget{
  late String _text = "";
  HeaderNotification(String text, {Key? key}) : super(key: key){
    _text = text;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_text, style: profileHeaderTextStyle),
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