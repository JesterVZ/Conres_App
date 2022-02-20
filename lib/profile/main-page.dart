import 'package:conres_app/contracts/contracts.dart';
import 'package:conres_app/profile/profile-ls.dart';
import 'package:conres_app/profile/profile-no-ls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../chats/chats.dart';
import '../claims/claims.dart';
import '../consts.dart';
import '../icons.dart';

class MainPage extends StatefulWidget{
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPage();
}
class _MainPage extends State<MainPage>{
  int _selectedPage = 0;
  List<Widget> pageList = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  void initState() {
    pageList.add(const ProfileNoLs());
    pageList.add(Contracts());
    pageList.add(const Claims());
    pageList.add(Chats());
    super.initState();
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
        ],
        currentIndex: _selectedPage,
        selectedItemColor: colorMain,
        onTap: _onItemTapped,
      ),
    );
  }
}