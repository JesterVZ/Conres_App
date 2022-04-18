import 'dart:convert';
import 'package:conres_app/chats/chats.dart';
import 'package:conres_app/profile/profile-test.dart';
import 'package:conres_app/profile/tab-item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../claims/claims.dart';
import '../contracts/contracts.dart';
import '../model/profile.dart';
import 'bottom-nav/bottom-navigation-custom.dart';
import 'navigators/tab-nav.dart';


class MainPage extends StatefulWidget{
  final Profile? profile;
  final List<dynamic>? loginData;
  MainPage({this.profile, this.loginData});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage>{
  var _currentTab = TabItem.main;
  final _navKeys = {
    TabItem.main: GlobalKey<NavigatorState>(),
    TabItem.contracts: GlobalKey<NavigatorState>(),
    TabItem.claims: GlobalKey<NavigatorState>(),
    TabItem.chats: GlobalKey<NavigatorState>()
  };
  List<Widget> navigatorList = [];

  @override
  void initState() {
    navigatorList.add(TabNavigator(
      navigatorKey: _navKeys[TabItem.main],
      profile: widget.profile,
      rootPage: ProfilePageTest(profile: widget.profile, loginData: widget.loginData),
    ));
    navigatorList.add(TabNavigator(
      navigatorKey: _navKeys[TabItem.contracts],
      rootPage: Contracts()
    ));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.claims],
        rootPage: Claims()
    ));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.chats],
        rootPage: Chats()
    ));
  }

  void _selectTab(TabItem tabItem) {
    if(tabItem == _currentTab){
      _navKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      final isFirstRouteInCurrentTab = !await _navKeys[_currentTab]!.currentState!.maybePop();

      if(isFirstRouteInCurrentTab){
        //Не страница 'main'
        if(_currentTab != TabItem.main){
          _selectTab(TabItem.main);
          return false;
        }
      }
      return isFirstRouteInCurrentTab;
    },
      child: Scaffold(
        body: IndexedStack(
          index: _currentTab.index,
          children: [
            _buildOffstageNavigator(TabItem.main, navigatorList[0]),
            _buildOffstageNavigator(TabItem.contracts, navigatorList[1]),
            _buildOffstageNavigator(TabItem.claims, navigatorList[2]),
            _buildOffstageNavigator(TabItem.chats, navigatorList[3]),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem, Widget navigator) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: navigator,
    );
  }

}