import 'package:flutter/cupertino.dart';

class TicketElement extends StatefulWidget{
  Widget status = Container();
  late int number;
  late String ticket;
  @override
  State<StatefulWidget> createState() => _TicketElement();
}

class _TicketElement extends State<TicketElement>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            widget.status,
            Text("Обращение № " + widget.number.toString())
          ],
        ),
        Text(widget.ticket)
      ],
    );
  }

}