import 'dart:io';

import 'package:conres_app/DI/dependency-provider.dart';
import 'package:flutter/material.dart';

import 'consts.dart';
import 'login/login-account.dart';
import 'login/login-main.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
      DependencyProvider(
          child: const MyApp()
      )
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: defaultBackground,
        fontFamily: 'Bubicon-Medium'
      ),
      home: LoginPage(),
    );
  }
}
