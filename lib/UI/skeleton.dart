import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/* 
skeleton.dart
Скелетон-виджет анимированный, отображается во время загрузки данных

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class Skeleton extends StatefulWidget {
  final double height;
  final double width;

  Skeleton({Key? key, this.height = 20, this.width = 200 }) : super(key: key);

  createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  Animation? gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear
      ),
    )..addListener(() {
      setState(() {});
    });

    _controller!.repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width:  widget.width,
        height: widget.height, 
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            begin: Alignment(gradientPosition!.value, 0),
            end: Alignment(-1, 0),
            colors: [Colors.black12, Colors.black26, Colors.black12]
          )
        ),
    );
  }
}