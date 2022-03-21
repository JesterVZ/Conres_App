import 'package:flutter/cupertino.dart';

class Status extends StatelessWidget{
  late Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        color: color
      ),
    );
  }
}