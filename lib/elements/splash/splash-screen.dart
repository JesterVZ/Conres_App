import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../loading/loading-page.dart';
/* 
splash-screen.dart
Экран завтавки

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async{
    await Future.delayed(Duration(milliseconds: 2000));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoadingPage()), (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/splash.jpg')
        )
      ),
      child: Center(
        child: SvgPicture.asset('assets/splash-logo.svg'),
      ),
    );
  }
}