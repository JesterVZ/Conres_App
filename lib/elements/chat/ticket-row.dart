import 'dart:developer';

import 'package:conres_app/elements/chat/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import '../../model/ticket.dart';

class TicketRow extends StatefulWidget{ 
  Ticket ticket;
  ValueChanged<Ticket>? openChat;
  String? counter;
  TicketRow({required this.ticket, this.openChat, this.counter});

@override
  State<StatefulWidget> createState() => _TicketRow();
}

class _TicketRow extends State<TicketRow>{
  Color? nameColor;
  Color? backgroundColor;
    @override
  void initState() {
    if(widget.ticket.cur_status != null){
      switch(widget.ticket.cur_status!.name){
        case "Открыт":
        nameColor = Colors.green.shade800;
        backgroundColor = Colors.green.shade200;
        break;
        case "Закрыт":
        nameColor = Colors.red.shade800;
        backgroundColor = Colors.red.shade200;
        break;
        case "В обработке":
        nameColor = Colors.red.shade800;
        backgroundColor = Colors.red.shade200;
        break;
      }
    }

    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.openChat!.call(widget.ticket);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(children: [
              Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text("ОБРАЩЕНИЕ № ${widget.ticket.ticket_id}"),
                    Status(
                      name: widget.ticket.cur_status != null ? widget.ticket.cur_status!.name : "",
                      color: nameColor ?? Colors.white,
                      backgroundColor: backgroundColor ?? Colors.white,
                    )
                    
                ]),
                
                Text("c ${widget.ticket.date_added}", style: TextStyle(
                    color: colorGrayClaim,
                    fontSize: 12
                )),
                Text("c ${widget.ticket.contact_email}", style: TextStyle(
                    color: colorGrayClaim,
                    fontSize: 12
                ))
              ],
            ),
            const Spacer(),
            Visibility(
              visible: widget.counter != "0" ? true : false,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red
                ),
                child: Center(child: Text(widget.counter!, style: const TextStyle(
                  color: Colors.white
                ))),
              ))
        ]),
      ),
    );
  }
}