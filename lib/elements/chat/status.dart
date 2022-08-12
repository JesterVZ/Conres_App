import 'package:flutter/cupertino.dart';

class Status extends StatelessWidget{
  Color color;
  Color backgroundColor;
  String? name;

  Status({
    required this.color,
    required this.name,
    required this.backgroundColor
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor
      ),
      child: Text(name!, style: TextStyle(
        color: color
      )),
    );
  }
}