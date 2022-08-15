import 'dart:convert';
import 'dart:math';
import 'package:conres_app/Services/update-claim-service.dart';
import 'package:conres_app/Services/update-ticket-service.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/chats/chats.dart';
import 'package:conres_app/loading/loading-page.dart';
import 'package:conres_app/profile/profile-test.dart';
import 'package:conres_app/profile/tab-item.dart';
import 'package:conres_app/websocket/websocket-listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-state.dart';
import '../chats/messages.dart';
import '../claims/claims.dart';
import '../contracts/contracts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/route/def-page-router.dart';
import '../login/login-main.dart';
import '../model/contract.dart';
import '../model/profile.dart';
import '../more/more.dart';
import '../websocket/websocket.dart';
import 'bottom-nav/bottom-navigation-custom.dart';
import 'navigators/tab-nav.dart';

class MainPage extends StatefulWidget {
  final List<dynamic>? loginData;
  final List cookies;
  MainPage({required this.cookies, this.loginData});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  WebSocketChannel? webSocketChannel;
  WebSocketData? webSocketData;
  WebSocketListener? webSocketListener;
  UpdateClaimService? updateClaimService;
  UpdateTicketService? updateTicketService;
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

  bool isConnected = false;

  @override
  void initState() {
    navigatorList.add(TabNavigator(
      navigatorKey: _navKeys[TabItem.main],
      rootPage:
          ProfilePageTest(loginData: widget.loginData, func: goToContract, cookies: widget.cookies,),
    ));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.contracts], rootPage: Contracts(canLogin: false, func: goToContract)));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.claims], rootPage: Claims(mainListener: getData,)));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.chats],
        rootPage: Chats(mainListener: getData,)));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.more], rootPage: MoreScreen(logout: logout)));
  }

  void logout() async {
    webSocketListener = null;
    webSocketChannel = null;
    profileBloc!.logout();
  }

  void goToContract(Contract contract) async{
    Navigator.pushAndRemoveUntil(context, DefaultPageRouter(LoadingPage(newLogin: contract.account_number,)), (route) => false);
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
          return Container(
            child: WillPopScope(
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
          ),
          );

          
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.cookieStr != null) {
      if(webSocketChannel != null){
        if(isConnected == false){
          webSocketChannel!.sink.add(state.cookieStr);
          isConnected = true;
        }
        
      }
    }
    if(state.loginData != null){
      if (state.loginData!.isEmpty){
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
      }
    }
    /*
    if (state.loginData!.isEmpty || state.loginData == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    }
    */
  }

  Widget _buildOffstageNavigator(TabItem tabItem, Widget navigator) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: navigator,
    );
  }

  void getData(dynamic event) async {
    print('\x1B[33m$event\x1B[0m');
    if(this.mounted){
      setState(() {
        try{
        webSocketData = WebSocketData.fromMap(jsonDecode(event.toString()));
        if(webSocketData!.data!['counters'] != null){
          ticketCounter=webSocketData!.data!['counters']['new_ticket_messages_count'];
          claimCounter = webSocketData!.data!['counters']['new_claims_messages_count'];
        }
        if(webSocketData!.event == "claim_status"){
          updateClaimService!.update!.call(webSocketData!.data['claim_id'], webSocketData!.data['status'], webSocketData!.data['status_pay']);
        }

        if(webSocketData!.event == "ticket_msg"){
          updateTicketService!.update!.call(webSocketData!.data['ticket_info'][0]['ticket_id'], webSocketData!.data['ticket_info'][0]['name']);
        }

        }catch(e){
          print(e);
        }

      });
    }

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel;
    webSocketData ??= DependencyProvider.of(context)!.webSocketData;
    webSocketListener ??= DependencyProvider.of(context)!.webSocketListener;
    updateClaimService ??= DependencyProvider.of(context)!.updateClaimService;
    updateTicketService ??= DependencyProvider.of(context)!.updateTicketService;
    webSocketListener?.webSocketChannel = webSocketChannel;
    webSocketListener?.function = getData;
    profileBloc!.getCookies(widget.cookies);
    webSocketListener!.listen();
  }
}
