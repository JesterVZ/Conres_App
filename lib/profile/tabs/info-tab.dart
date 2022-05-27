import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';

class InfoTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoTab();
}

class _InfoTab extends State<InfoTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: defaultBackground,
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ФИО",
                                        style:
                                            TextStyle(color: colorGrayClaim)),
                                    const Text("Иванов2 Иван Иванович",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Юридический адрес",
                                        style:
                                            TextStyle(color: colorGrayClaim)),
                                    const Text("Иванов2 Иван Иванович",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ИНН",
                                        style:
                                            TextStyle(color: colorGrayClaim)),
                                    const Text("Иванов2 Иван Иванович",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ОГРНИП",
                                        style:
                                            TextStyle(color: colorGrayClaim)),
                                    const Text("Иванов2 Иван Иванович",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Пароль",
                                        style:
                                            TextStyle(color: colorGrayClaim)),
                                    const Text("************",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ))
                          ],
                        ),
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Редактировать"),
                      style: ElevatedButton.styleFrom(
                          primary: colorMain,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)))),
                ),
                Container(
                  child: Column(children: [
                    const Text("Быстрая авторизация",
                        style: TextStyle(color: Colors.black, fontSize: 24)),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 264,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/vk-svg.svg'),
                                        Container(
                                          margin: EdgeInsets.only(left: 21),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text("Вконтакте",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text("Запрещенно")
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFC8D8FF),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 5,
                                                  color:
                                                      const Color(0xFFF2F6FF))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/Google-svg.svg'),
                                        Container(
                                          margin: EdgeInsets.only(left: 21),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text("Google",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text("Запрещенно")
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFC8D8FF),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 5,
                                                  color:
                                                      const Color(0xFFF2F6FF))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/Yandex-svg.svg'),
                                        Container(
                                          margin: EdgeInsets.only(left: 21),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text("Yandex",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text("Запрещенно")
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFC8D8FF),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 5,
                                                  color:
                                                      const Color(0xFFF2F6FF))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/OK-svg.svg'),
                                        Container(
                                          margin: EdgeInsets.only(left: 21),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text("Одноклассники",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text("Запрещенно")
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFC8D8FF),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 5,
                                                  color:
                                                      const Color(0xFFF2F6FF))),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )))
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
