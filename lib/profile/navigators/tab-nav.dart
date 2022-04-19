import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/profile.dart';
import '../../testimony/send-testimony.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String testimony = '/testimony';
}

class TabNavigator extends StatelessWidget{
  TabNavigator({required this.navigatorKey, required this.rootPage, this.profile, this.loginData});

  final GlobalKey<NavigatorState>? navigatorKey;
  final Profile? profile;
  final List<dynamic>? loginData;
  final Widget rootPage;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, String? personal){
    return {
      TabNavigatorRoutes.root: (context) => rootPage,
      TabNavigatorRoutes.testimony: (context) => SendTestimony(personal: personal),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context, profile != null ? profile!.personal : '');
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings){
        return MaterialPageRoute(builder: (context) => routeBuilders[routeSettings.name!]!(context));
      },
    );
  }
}