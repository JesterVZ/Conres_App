import 'package:conres_app/registration/seccessful-registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../consts.dart';
import '../elements/header.dart';

class RegIP extends StatefulWidget {
  const RegIP({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegIP();
}

class _RegIP extends State<RegIP> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool _agree = false;

  final Widget plusSVG = SvgPicture.asset('assets/plus.svg',
      color: colorLogo);
  final Widget minusSVG = SvgPicture.asset('assets/minus.svg',
      color: colorLogo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(21, 70, 21, 54),
                child: Column(
                  children: [
                    HeaderRow(regTitle),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 38, 0, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(familyIP,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              decoration: InputDecoration(
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
                            Text(nameIP,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              decoration: InputDecoration(
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
                            Text(patronymicIP,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              decoration: InputDecoration(
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
                            TextField(
                              decoration: InputDecoration(
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
                            Text(ofrnip,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              decoration: InputDecoration(
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
                            Text(contacts,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              decoration: InputDecoration(
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
                            Text(email,
                                style: TextStyle(
                                    color: colorGray, fontSize: 16.0)),
                            TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: inputBorder))),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: Column(
                          children: [
                            ElevatedButton(
                                onPressed: (){},
                                child: plusSVG)
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
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
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
                            Navigator.push(context, MaterialPageRoute(builder:  (context) => const RegSuccess()));
                          },
                          child: Text(
                            login,
                            style: const TextStyle(fontSize: 18.0),
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
