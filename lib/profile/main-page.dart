import 'dart:convert';
import 'dart:math';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/chats/chats.dart';
import 'package:conres_app/profile/profile-test.dart';
import 'package:conres_app/profile/tab-item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-state.dart';
import '../chats/messages.dart';
import '../claims/claims.dart';
import '../contracts/contracts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../login/login-main.dart';
import '../model/profile.dart';
import '../more/more.dart';
import '../websocket/websocket.dart';
import 'bottom-nav/bottom-navigation-custom.dart';
import 'navigators/tab-nav.dart';

class MainPage extends StatefulWidget {
  final Profile? profile;
  final List<dynamic>? loginData;
  MainPage({this.profile, this.loginData});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  WebSocketChannel? webSocketChannel;
  WebSocketData? webSocketData;
  int? ticketCounter;
  int? claimCounter;
  var _currentTab = TabItem.main;
  final _navKeys = {
    TabItem.main: GlobalKey<NavigatorState>(),
    TabItem.contracts: GlobalKey<NavigatorState>(),
    TabItem.claims: GlobalKey<NavigatorState>(),
    TabItem.chats: GlobalKey<NavigatorState>(),
    TabItem.more: GlobalKey<NavigatorState>()
  };
  List<Widget> navigatorList = [];
  ProfileBloc? profileBloc;

  @override
  void initState() {
    navigatorList.add(TabNavigator(
      navigatorKey: _navKeys[TabItem.main],
      profile: widget.profile,
      rootPage:
          ProfilePageTest(profile: widget.profile, loginData: widget.loginData),
    ));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.contracts], rootPage: Contracts()));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.claims], rootPage: Claims()));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.chats],
        rootPage: Chats(profile: widget.profile!)));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.more], rootPage: MoreScreen(logout)));
  }

  void logout() {
    profileBloc!.logout();
  }

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      _navKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              final isFirstRouteInCurrentTab =
                  !await _navKeys[_currentTab]!.currentState!.maybePop();

              if (isFirstRouteInCurrentTab) {
                //Не страница 'main'
                if (_currentTab != TabItem.main) {
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
                  _buildOffstageNavigator(TabItem.more, navigatorList[4]),
                ],
              ),
              bottomNavigationBar: BottomNavigation(
                currentTab: _currentTab,
                onSelectTab: _selectTab,
                ticketCounter: ticketCounter,
                claimCounter: claimCounter,
              ),
            ),
          );
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.cookieStr != null) {
      webSocketChannel!.sink.add(state.cookieStr);
    }
    if (state.loginData!.isEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    }
  }

  Widget _buildOffstageNavigator(TabItem tabItem, Widget navigator) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: navigator,
    );
  }

  void getData() async {
    webSocketChannel!.stream.listen((event) {
      print('\x1B[33m$event\x1B[0m');
      setState(() {
        webSocketData = WebSocketData.fromMap(jsonDecode(event.toString()));
        ticketCounter =
            webSocketData!.data!.counters!.new_ticket_messages_count;
        claimCounter = webSocketData!.data!.counters!.new_claims_messages_count;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel;
    webSocketData ??= DependencyProvider.of(context)!.webSocketData;
    profileBloc!.getCookies(
        widget.loginData![0], widget.loginData![1], widget.loginData![2]);
    getData();
  }
}
