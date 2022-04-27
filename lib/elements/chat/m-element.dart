import 'package:flutter/cupertino.dart';

class MessageBox extends StatelessWidget{
  String text;
  Color rectangleColor;
  Color textColor;
  MessageBox({required this.text, required this.textColor, required this.rectangleColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 11, 27, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: rectangleColor
      ),
      child: Text(text, style: TextStyle(
        color: textColor
      )),
    );
  }
}