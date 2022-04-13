import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/profile.dart';
import '../../testimony/send-testimony.dart';
import '../profile-test.dart';
import '../tab-item.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String testimony = '/testimony';
}

class TabNavigator extends StatelessWidget{
  TabNavigator({required this.navigatorKey, required this.tabItem, this.profile, this.loginData});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;
  Profile? profile;
  final List<dynamic>? loginData;

  void _push(BuildContext context, {required String? personal}){
    var routeBuilders = _routeBuilders(context, personal);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.testimony]!(context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, String? personal){
    return {
      TabNavigatorRoutes.root: (context) => ProfilePageTest(profile: profile, loginData: loginData, onPush: (value){
        _push(context, personal: personal);
      }),
      TabNavigatorRoutes.testimony: (context) => SendTestimony(personal: personal)
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context, profile!.personal);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings){
        return MaterialPageRoute(builder: (context) => routeBuilders[routeSettings.name!]!(context));
      },
    );
  }
}