import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../claims/new-claim/new-claim-step-1.dart';
import '../consts.dart';
import '../icons.dart';

class ProfileNoLs extends StatefulWidget {
  const ProfileNoLs({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileNoLs();
}

class _ProfileNoLs extends State<ProfileNoLs> {
  final Widget fileSVG = SvgPicture.asset('assets/file-icon.svg', color: colorMain,
      );
  String thisInn = "19982215874";
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(17, 59, 17, 0),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        profile,
                        style: const TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: profileColor,
                        border: Border.all(color: borderProfileColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(inn,
                                        style: TextStyle(
                                            color: profileLabelColor,
                                            fontSize: 15)),
                                    Text(thisInn,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18))
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(gpINN,
                                        style: TextStyle(
                                            color: profileLabelColor,
                                            fontSize: 15)),
                                    Text(needDogovor,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18))
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(emailProfile,
                                        style: TextStyle(
                                            color: profileLabelColor,
                                            fontSize: 15)),
                                    const Text("Ahiro2011@gmail.com",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18))
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(address,
                                        style: TextStyle(
                                            color: profileLabelColor,
                                            fontSize: 15)),
                                    const Text("-/-",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18))
                                  ],
                                ))
                          ],
                        )),
                  ),
                ],
              ),
              Positioned(
                  bottom: 24,
                  child: Container(
                      width: MediaQuery.of(context).size.width - 35,
                      height: 70,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewClaimStep1()));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: contractBtnColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset('assets/file-icon.svg', color: colorMain,),
                                ),
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              ),
                              Text(
                                "Заключитить договор с РСО",
                                style: TextStyle(color: colorMain, fontSize: 18),
                              )
                            ],
                          ))))
            ],
          )),
    );
  }
}
