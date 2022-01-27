import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../custom_elements/custom_radio.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _value2 = 0;
  final List<GroupModel> _group = [
    GroupModel(text: "Физичские лицо", index: 1, selected: true),
    GroupModel(text: "Индивидуальный предприниматель", index: 2, selected: false),
    GroupModel(text: "Юридическое лицо", index: 3, selected: false),
  ];
  Widget makeRadioTiles() {
    List<Widget> list = [];
    for (int i = 0; i < _group.length; i++) {
      list.add(Container(
        decoration: BoxDecoration(
            color: _group[i].selected ? colorMain : Colors.white,
            borderRadius: (i == 0) ? const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                : (i == 2) ? const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : BorderRadius.circular(0)),
        child: RadioListTile(
          value: _group[i].index,
          groupValue: _value2,
          selected: _group[i].selected,
          onChanged: (val){
            setState(() {
              for (int i = 0; i < _group.length; i++) {
                _group[i].selected = false;
              }
              _value2 = val as int;
              _group[i].selected = true;
            });
          },
          activeColor: Colors.white,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text(
            ' ${_group[i].text}',
            style: TextStyle(
                color: _group[i].selected ? Colors.white : Colors.black,
                ),
          ),
        ),
      ));
    }
    Container container = Container(
      child: Column(
        children: list,
      ),
    );
    return container;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('assets/logo.jpg')),
                    Container(
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Roboto',
                                color: colorMain)),
                        margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0))
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 1.2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3),)]),
                  child: Container(padding: const EdgeInsets.all(16.0),
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Text(
                          lkTitle,
                          style: const TextStyle(
                              fontSize: 15.2, fontFamily: 'Roboto'),
                        ),
                      ),

                      Text(
                        lkChooseType,
                        style: const TextStyle(
                            fontSize: 10.2,
                          fontFamily: 'Roboto-Medium'
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: makeRadioTiles(),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TextField(
                          controller: lkController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Лицевой счет, телефон, email или ИНН',
                          ),

                        ),
                      ),

                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Пароль',
                        ),

                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: (){},
                              child: Text("Войти"),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(40),
                                co
                              ))
                        ],
                      )

                    ],
                  ),)

                ),
              )
            ],
          ),
        ));
  }
}
