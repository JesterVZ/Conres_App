import 'package:conres_app/model/result-dara.dart';
import 'package:conres_app/registration/seccessful-registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../consts.dart';
import '../elements/header.dart';
import '../elements/masks.dart';
import '../model/model.dart';
import '../network.dart';

class RegFL extends StatefulWidget {
  const RegFL({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegFL();
}

class _RegFL extends State<RegFL> {
  final controllerList = List<TextEditingController>.generate(9, (index) => TextEditingController());
  late bool _agree = false;
  var fetchData;

  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: fetchData,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  if(snapshot is ResultData){
                    Navigator.push(context, MaterialPageRoute(builder:  (context) => const RegSuccess()));
                    return const Text("");
                  } else{
                    return const Text("Ошибка регистрации");
                  }
                } else {
                  return const Text("другая ошибка");
                }
              }
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(21, 70, 21, 54),
                child: Column(
                  children: [
                    HeaderRow(regTitle, 34, false),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 38, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(family,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[0],
                              decoration: InputDecoration(
                                hintText: "Иванов",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[1],
                              decoration: InputDecoration(
                                hintText: "Иван",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(patronymic,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[2],
                              decoration: InputDecoration(
                                hintText: "Иванович",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(inn,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            MaskInput(
                              textController: controllerList[3],
                              formatter: MaskTextInputFormatter(mask: "############"),
                              hint: "000000000000",
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snils,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),

                            MaskInput(
                              textController: controllerList[4],
                              formatter: MaskTextInputFormatter(mask: "###-###-###-##"),
                              hint: "000-000-000-00",
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(contacts,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            MaskInput(
                              textController: controllerList[5],
                              formatter: MaskTextInputFormatter(mask: "+# (###) ###-##-##"),
                              hint: "+7 (___) - ___ - __ - __",
                            ),

                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(email,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[6],
                              decoration: InputDecoration(
                                hintText: "example@email.ru",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lkPasswordText,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[7],
                              autofocus: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Ваш пароль",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(repeatPassword,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              controller: controllerList[8],
                              autofocus: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Повторите пароль",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                    child: Row(
                      children: [
                        Checkbox(
                            value: _agree,

                            activeColor: colorMain,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                            onChanged: (value){
                          setState(() {
                            _agree = !_agree;
                          });
                        }),
                        Container(width: 284, child: Text("Я согласен на обработку персональных данных", style: TextStyle(fontSize: 15))),
                      ],
                    ),),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: ElevatedButton(
                          onPressed: () {
                            Fl flObj = Fl(
                              Family: controllerList[0].text,
                              Name: controllerList[1].text,
                              Patronymic: controllerList[2].text,
                              Password: controllerList[7].text,
                              RepeatPassword: controllerList[8].text,
                              Inn: controllerList[3].text,
                              Snils: controllerList[4].text,
                              Email: controllerList[6].text,
                              Tel: controllerList[5].text

                            );
                            fetchData = registrationFunc(flObj);
                            //Navigator.push(context, MaterialPageRoute(builder:  (context) => const RegSuccess()));
                          },
                          child: Text(
                            login,
                            style: buttonTextStyle
                          ),
                          style: ElevatedButton.styleFrom(primary: colorMain)),
                    )
                    
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
