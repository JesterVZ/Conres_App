import 'package:flutter/cupertino.dart';

class DefaultPageRouter extends PageRouteBuilder{
  final Widget widget;

  DefaultPageRouter(this.widget) : super(
    transitionDuration: Duration.zero,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondAnimation){
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondAnimation, Widget child){
      return FadeTr
    }
    )
  )
}