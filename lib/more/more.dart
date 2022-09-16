import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UI/default-button.dart';
import '../consts.dart';
import '../elements/header/header-notification.dart';
import '../elements/header/header.dart';
import '../profile/full-profile-page.dart';
import '../testimony/info-pu.dart';
import '../testimony/objects-pu.dart';

class MoreScreen extends StatefulWidget {
  final VoidCallback logout;
  MoreScreen({required this.logout});
  @override
  State<StatefulWidget> createState() => _MoreScreen();
}

class _MoreScreen extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                child: Column(
                  children: [
                    Container(
                  margin: EdgeInsets.only(top: 52),
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding, bottom: 12),
                    child: HeaderNotification(
                      text: "Ещё",
                    )),
                    Container(
                      child: Image.network("https://rep.dev.conres.ru/files_rso/107/settings/logo_107.png"),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              DefaultButton(text: "Информация о ПУ", onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ObjectsPU()));
                              }, margin: EdgeInsets.only(bottom: 12),),
                              DefaultButton(text: "Профиль", onPressed: (){}, margin: EdgeInsets.only(bottom: 12)),
                              DefaultButton(text: "Заявление на тех. присоединение", onPressed: (){}, margin: EdgeInsets.only(bottom: 12)),
                              DefaultButton(text: "Информация", onPressed: (){}, margin: EdgeInsets.only(bottom: 12)),
                              DefaultButton(text: "Показания умных ПУ", onPressed: (){}, margin: EdgeInsets.only(bottom: 12)),
                              DefaultButton(text: "Выход", onPressed: (){
                                widget.logout.call();
                              },)
                            ],
                          ),
                        )
                                        ),
                  ],
                ),
              )
    );
  }
}
