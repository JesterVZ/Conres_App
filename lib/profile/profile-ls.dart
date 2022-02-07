import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../consts.dart';
import '../icons.dart';

class ProfileLs extends StatefulWidget {
  const ProfileLs({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileLs();
}

class _ProfileLs extends State<ProfileLs> {
  String thisInn = "19982215874";
  String thisLS = "345672309";
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
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                    decoration: BoxDecoration(
                        color: profileColor,
                        border: Border.all(color: borderProfileColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ls,
                                style: TextStyle(
                                    color: profileLabelColor,
                                    fontSize: 15, fontFamily: 'Bubicon-Medium')),
                            Text(thisLS,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18, fontFamily: 'Bubicon-Medium'))
                          ],
                        ),
                        const Spacer(),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: lsButtonColor,
                            shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(13, 9, 11, 9),
                            child: SvgPicture.asset("assets/ls-right-arrow.svg", color: colorMain,),
                          ),
                        )
                      ],
                    )),
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
                                            fontFamily: 'Bubicon-Medium',
                                            color: profileLabelColor,
                                            fontSize: 15)),
                                    Text(thisInn,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18, fontFamily: 'Bubicon-Medium'))
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
                                            fontSize: 15,
                                            fontFamily: 'Bubicon-Medium')),
                                    Text(needDogovor,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18, fontFamily: 'Bubicon-Medium'))
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
                                            fontSize: 15, fontFamily: 'Bubicon-Medium')),
                                    const Text("Ahiro2011@gmail.com",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18, fontFamily: 'Bubicon-Medium'))
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
                                            fontSize: 15, fontFamily: 'Bubicon-Medium')),
                                    const Text("-/-",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18, fontFamily: 'Bubicon-Medium'))
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: colorGray, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          )),

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
                                  child: SvgPicture.asset('assets/meters-data.svg', color: colorGray,),
                                ),
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              ),
                              const Text(
                                "Передать показания",
                                style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Bubicon-Medium'),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    color: meterDataColor,
                                    shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(13, 9, 11, 9),
                                  child: SvgPicture.asset("assets/ls-right-arrow.svg", color: Colors.white,),
                                ),
                              )
                            ],
                          ))))
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.home, color: colorGray),
                label: mainPage),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.contracts, color: colorGray),
                label: contractsPage),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.reports, color: colorGray),
                label: reportsPage),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.chat, color: colorGray),
                label: chatPage),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: colorMain,
          onTap: _onItemTapped),
    );
  }
}
