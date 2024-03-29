import 'dart:io';

import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/DI/locator.dart';
import 'package:conres_app/profile/full-profile-page.dart';
import 'package:conres_app/select-store/select-store.dart';
import 'package:flutter/material.dart';
import 'consts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'elements/splash/splash-screen.dart';
import 'loading/loading-page.dart';
import 'login/login-main.dart';
/* 
main
Точка входа в приложение, основной файл.

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
void main() {
  HttpOverrides.global = MyHttpOverrides();
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(DependencyProvider(child: const MyApp()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru')
      ],
      title: 'Контроль ресурсов',
      routes: {
        '/logout': (context) => LoginPage(),
        '/user_info':(context) => FullProfile(),
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: pageColor,
          fontFamily: 'Bubicon-Medium'),
      //home: SplashScreen(),
      home: SelectStore(),
    );
  }
}
