import 'package:flutter/cupertino.dart';

class TicketElement extends StatefulWidget{

  Widget status = Container();
  late int number;
  late String ticket;
  @override
  State<StatefulWidget> createState() => _TicketElement();

  TicketElement(this.number, this.ticket);
}

class _TicketElement extends State<TicketElement>{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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