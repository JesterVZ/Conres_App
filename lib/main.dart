import 'dart:io';

import 'package:conres_app/DI/dependency-provider.dart';
import 'package:flutter/material.dart';
import 'consts.dart';
import 'elements/splash/splash-screen.dart';
import 'loading/loading-page.dart';
import 'login/login-main.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
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


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();

}

class _MyApp extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Контроль ресурсов',
      routes: {
        '/logout': (context) => LoginPage(),

      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: defaultBackground,
          fontFamily: 'Bubicon-Medium'
      ),
      home: LoadingPage(),
    );

  }

}