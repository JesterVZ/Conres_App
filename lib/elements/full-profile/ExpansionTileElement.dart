import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpansionTileElement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpansionTileElement();
}

class _ExpansionTileElement extends State<ExpansionTileElement> {
  bool canLogin = false;
  bool claimNotification = false;
  bool ticketNotification = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1, bottom: 10),
      //padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Номер телефона",
                      style: TextStyle(color: colorGrayClaim)),
                  const Text("+7 (919) 466-45-92",
                      style: TextStyle(fontSize: 18)),
                  
                ],
              )),
          ExpansionTile(
            maintainState: true,
            
            title: Text("Настройки"),
            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Тип контакта",
                                style: TextStyle(
                                    color: colorGrayClaim, fontSize: 15)),
                            const Text("Мобильный телефон",
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Логин",
                            style:
                                TextStyle(fontSize: 15, color: colorGrayClaim)),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                          decoration: BoxDecoration(
                              color: const Color(0xFFfafafb),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/lock.svg'),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: const Text("Вход в качестве логина"),
                              ),
                              const Spacer(),
                              Switch(
                                  value: canLogin,
                                  onChanged: (val) => setState(() {
                                        canLogin = val;
                                      }))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                      Text("Отправка уведомлений",
                          style: TextStyle(color: colorGrayClaim)),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                        decoration: BoxDecoration(
                            color: const Color(0xFFfafafb),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/lock.svg'),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: const Text("Заявления"),
                            ),
                            const Spacer(),
                            Switch(
                                value: claimNotification,
                                onChanged: (val) => setState(() {
                                      claimNotification = val;
                                    }))
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                        decoration: BoxDecoration(
                            color: const Color(0xFFfafafb),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/lock.svg'),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: const Text("Обращения"),
                            ),
                            const Spacer(),
                            Switch(
                                value: ticketNotification,
                                onChanged: (val) => setState(() {
                                      ticketNotification = val;
                                    }))
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 142,
                                    height: 55,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            primary: colorMain,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        child: const Text("Изменить")),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 142,
                                    height: 55,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            primary: colorMain,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        child: const Text("Добавить")),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 55,
                              child: ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: messageColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child: const Text("Свернуть",
                                      style: TextStyle(color: Colors.black))),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
