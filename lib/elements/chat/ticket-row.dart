import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import '../../model/ticket.dart';

class TicketRow extends StatelessWidget{
  Ticket ticket;
  VoidCallback? openChat;
  TicketRow({required this.ticket, this.openChat});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        openChat;
      },
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ОБРАЩЕНИЕ № ${ticket.ticket_id}"),
            Text("c ${ticket.date_added}", style: TextStyle(
                color: colorGrayClaim,
                fontSize: 12
            )),
            Text("c ${ticket.contact_email}", style: TextStyle(
                color: colorGrayClaim,
                fontSize: 12
            ))
          ],
        ),
      ),
    );
  }
}