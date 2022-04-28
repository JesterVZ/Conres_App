import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../consts.dart';
import '../elements/chat/m-element.dart';
import '../elements/chat/mesage-row.dart';
import '../elements/header/header.dart';

class MessagesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_MessagesPage();
}

class _MessagesPage extends State<MessagesPage>{
  List<Widget> messages = [];
  TextEditingController controller = TextEditingController();
  void _send(){
    setState(() {
      messages.add(MessageRow(text: controller.text, isOwn: true));
      controller.text = "";
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
                height: 100,
                child: HeaderNotification(text: "Сообщения")
            ),
            Expanded(child: Scrollbar(child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        //здесь сообщения
                        Column(
                          children: messages,
                        ),

                      ],
                    )
                  ],
                )
            ))),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    children: [
                      GestureDetector(
                          child: SvgPicture.asset('assets/clip.svg')
                      ),
                      const Spacer(),
                      Container(
                        width: 245,
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                              hintText: "Сообщение...",
                              fillColor: messageColor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)
                              )
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          _send();
                        },
                        child: Container(
                          padding: EdgeInsets.all(14),
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorMain,
                          ),
                          child: Container(
                            width: 18,
                            height: 14,
                            child: SvgPicture.asset('assets/arrow-type2.svg'),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}