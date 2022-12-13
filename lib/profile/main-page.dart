import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:conres_app/DI/locator.dart';
import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/Services/update-account-service.dart';
import 'package:conres_app/Services/update-claim-service.dart';
import 'package:conres_app/Services/update-meter-service.dart';
import 'package:conres_app/Services/update-object-service.dart';
import 'package:conres_app/Services/update-ticket-service.dart';
import 'package:conres_app/Services/update-tu-service.dart';
import 'package:conres_app/bloc/auth/auth-block.dart';
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
import '../Services/bottom-navigation-select-service.dart';
import '../bloc/profile/profile-state.dart';
import '../chats/messages.dart';
import '../claims/claims.dart';
import '../consts.dart';
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
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  WebSocketChannel? webSocketChannel;
  WebSocketData? webSocketData;
  WebSocketListener? webSocketListener;
  UpdateClaimService? updateClaimService;
  UpdateTicketService? updateTicketService;
  UpdateAccountService? updateAccountService;
  UpdateObjectService? updateObjectService;
  UpdateTuService? updateTuService;
  UpdateMeterService? updateMeterService;
  BottomNavigationSelectService? bottomNavigationSelectService;
  ProfileService? profileService;
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
      rootPage: ProfilePageTest(
        func: goToContract,
      ),
    ));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.contracts],
        rootPage: Contracts(func: goToContract)));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.claims],
        rootPage: Claims(
          mainListener: getData,
        )));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.chats],
        rootPage: Chats(
          mainListener: getData,
        )));
    navigatorList.add(TabNavigator(
        navigatorKey: _navKeys[TabItem.more],
        rootPage: MoreScreen(logout: logout)));
  }

  void logout() async {
    profileBloc!.logout();
  }

  void goToContract(Contract contract) async {
    Navigator.pushAndRemoveUntil(
        context,
        DefaultPageRouter(LoadingPage(
          newLogin: contract.account_number,
        )),
        (route) => false);
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
                    _buildOffstageNavigator(
                        TabItem.contracts, navigatorList[1]),
                    _buildOffstageNavigator(TabItem.claims, navigatorList[2]),
                    _buildOffstageNavigator(TabItem.chats, navigatorList[3]),
                    _buildOffstageNavigator(TabItem.more, navigatorList[4]),
                  ],
                ),
                bottomNavigationBar: BottomNavigation(
                  bottomNavigationSelectService: bottomNavigationSelectService!,
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
    ticketCounter = state.ticketCounter ?? ticketCounter;
    claimCounter = state.claimCounter ?? claimCounter;
    if (state.loading == true) {
      return;
    }
    if (state.userInformation != null) {
      profileService!.userInformation = state.userInformation;
    }
    if (state.cookieStr != null) {
      if (webSocketChannel != null) {
        if (isConnected == false) {
          webSocketChannel!.sink.add(state.cookieStr);
          isConnected = true;
        }
      }
    } else {
      webSocketChannel!.sink.close();
    }
    if (state.loginData != null) {
      if (state.loginData!.isEmpty) {
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
    if (this.mounted) {
      setState(() {
        try {
          var wsMap = jsonDecode(event.toString());
          webSocketData = WebSocketData.fromMap(jsonDecode(event.toString()));
          if (webSocketData!.data!['counters'] != null) {
            profileBloc!.setCounters(
                wsMap['data']['counters']['new_ticket_messages_count'],
                wsMap['data']['counters']['new_claims_messages_count']);
          }
          switch (webSocketData!.event) {
            //claim events
            case "claim_status":
              updateClaimService!.update!.call(
                  webSocketData!.data['claim_id'],
                  webSocketData!.data['status'],
                  webSocketData!.data['status_pay']);
              break;
            //ticket events
            case "ticket_msg":
              updateTicketService!.update!.call(
                  webSocketData!.data['ticket_info'][0]['ticket_id'],
                  webSocketData!.data['ticket_info'][0]['name']);
              break;
            //account events
            case "account_accept":
              updateAccountService!.update!
                  .call(webSocketData!.data['account_id'], "2", null);
              break;
            case "account_cancel":
              updateAccountService!.update!.call(
                  webSocketData!.data['account_id'],
                  "0", //Не прошёл проверку
                  webSocketData!.data[
                      'comment'] //комментарий, который написал челик из РСО
                  );
              break;
            //object events
            case "object_binding_cancel":
              updateObjectService!.update!.call(
                  webSocketData!.data['object_id'],
                  "0",
                  webSocketData!.data['comment']);
              break;
            case "object_binding_accept":
              updateObjectService!.update!.call(
                  webSocketData!.data['object_id'],
                  "2",
                  webSocketData!.data['comment']);
              break;
            //tu events
            case "point_binding_cancel":
              updateTuService!.update!.call(webSocketData!.data['point_id'],
                  "0", webSocketData!.data['comment']);
              break;
            case "point_binding_accept":
              updateTuService!.update!.call(webSocketData!.data['point_id'],
                  "2", webSocketData!.data['comment']);
              break;
            case "point_binding_delete":
              updateTuService!.remove!.call(webSocketData!.data['point_id']);
              break;
            //pu events
            case "meter_binding_accept":
              updateMeterService!.update!.call(webSocketData!.data['meter_id'], "2", webSocketData!.data['comment']);
              break;
            case "meter_binding_cancel":
              updateMeterService!.update!.call(webSocketData!.data['meter_id'], "3", webSocketData!.data['comment']);
            break;
          }
        } catch (e) {
          print(e);
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel(true);
    webSocketData ??= DependencyProvider.of(context)!.webSocketData;
    webSocketListener ??= DependencyProvider.of(context)!.webSocketListener;
    updateClaimService ??= DependencyProvider.of(context)!.updateClaimService;
    updateTicketService ??= DependencyProvider.of(context)!.updateTicketService;
    updateObjectService ??= DependencyProvider.of(context)!.updateObjectService;
    updateTuService ??= DependencyProvider.of(context)!.updateTuService;
    profileService ??= DependencyProvider.of(context)!.profileService;
    updateMeterService ??= DependencyProvider.of(context)!.updateMeterService;
    updateAccountService ??=
        DependencyProvider.of(context)!.updateAccountService;
    bottomNavigationSelectService ??=
        DependencyProvider.of(context)!.bottomNavigationSelectService;
    bottomNavigationSelectService!.function = _selectTab;
    webSocketListener?.webSocketChannel = webSocketChannel;
    webSocketListener?.function = getData;
    profileBloc!.getCookies(cookiesList!);
    profileBloc!.getFullProfileInfo();
    profileBloc!.getFullObjectsInfo();
    webSocketListener!.listen();
  }
}
