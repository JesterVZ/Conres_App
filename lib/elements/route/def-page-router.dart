import 'package:flutter/cupertino.dart';
/* 
def-page-router.dart
Route без анимации

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class DefaultPageRouter extends PageRouteBuilder{
  final Widget widget;

  DefaultPageRouter(this.widget) : super(
    transitionDuration: Duration.zero,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondAnimation){
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondAnimation, Widget child){
      return child;
    });
}
