import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../consts.dart';

class HeaderNotification extends StatelessWidget{
  late String _text = "";
  HeaderNotification(String text){
    _text = text;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_text, style: profileHeaderTextStyle),
        Spacer(),
        GestureDetector(
          onTap: (){

          },
          child: SvgPicture.asset("assets/notification.svg"),
        )
      ],
    );
  }
}