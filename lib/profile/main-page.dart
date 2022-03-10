import 'package:conres_app/contracts/contracts.dart';
import 'package:conres_app/profile/profile-ls.dart';
import 'package:conres_app/profile/profile-no-ls.dart';
import 'package:conres_app/testimony/info-pu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chats/chats.dart';
import '../claims/claims.dart';
import '../claims/new-claim/new-claim-step-1.dart';
import '../consts.dart';
import '../icons.dart';
import '../model/profile.dart';
import '../shared-preferences/shared-preferences.dart';

class MainPage extends StatefulWidget{
  const MainPage({Key? key, this.loginData, this.profile}) : super(key: key);
  final List<dynamic>? loginData;
  final Profile? profile;

  @override
  State<StatefulWidget> createState() => _MainPage();
}
class _MainPage extends State<MainPage>{
  int _selectedPage = 0;
  List<Widget> pageList = [];
  late SharedPreferences preferences;

  void _onItemTapped(int index) {
    setState(() {
      if(index == 4){
        showMenu<String>(
          context: context,
          position: const RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
          items: <PopupMenuItem<String>>[
            PopupMenuItem<String>(
                child: const Text('Информация о ПУ'),
                onTap: (){
                  setState(() {
                    _selectedPage = 4;
                  });

            }),
            PopupMenuItem<String>(
                child: const Text('Заявление на тех. присоединение'),
                onTap: (){
                  setState(() {
                    _selectedPage = 5;
                  });
            }),
            PopupMenuItem<String>(
                child: const Text('Информация'), onTap:() {
            }),
            PopupMenuItem<String>(
                child: const Text('Выход'), onTap:() {
                  setState((){
                    Logout(preferences);
                  });
            }),
          ],
          elevation: 8.0,
      );
      } else {
        _selectedPage = index;
      }

    });
  }

  @override
  void initState() {
    if(widget.loginData != null){
      pageList.add(ProfilePage(loginData: widget.loginData));
    }
    if(widget.profile != null){
      pageList.add(ProfilePage(profile: widget.profile));
    }
    pageList.add(Contracts());
    pageList.add(const Claims());
    pageList.add(Chats());
    pageList.add(InfoPU());
    pageList.add(NewClaimStep1());
    initSharedPreferences();
    super.initState();
  }

  void initSharedPreferences() async{
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPage,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(CustomIcons.home),
              label: mainPage),
          BottomNavigationBarItem(
              icon: const Icon(CustomIcons.contracts),
              label: contractsPage),
          BottomNavigationBarItem(
              icon: const Icon(CustomIcons.reports),
              label: reportsPage),
          BottomNavigationBarItem(
              icon: const Icon(CustomIcons.chat),
              label: chatPage),
          BottomNavigationBarItem(
            icon: const Icon(CustomIcons.dot_3),
            label: moreAction
          )
        ],
        currentIndex: _selectedPage,
        selectedItemColor: colorMain,
        onTap: _onItemTapped,
      ),
    );
  }
}