import 'dart:developer';

import 'package:conres_app/elements/chat/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import '../../model/ticket.dart';

class TicketRow extends StatefulWidget {
  Ticket ticket;
  ValueChanged<Ticket>? openChat;
  String? counter;
  TicketRow({required this.ticket, this.openChat, this.counter});

  @override
  State<StatefulWidget> createState() => _TicketRow();
}

class _TicketRow extends State<TicketRow> {
  Color? nameColor;
  Color? backgroundColor;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding),
      child: Container(
        margin: EdgeInsets.only(top: 14, bottom: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(17),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: inputBorder))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 19),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text("ОБРАЩЕНИЕ № ${widget.ticket.ticket_id}",
                              style: TextStyle(
                                  fontSize: 15, color: colorGrayClaim)),
                          Visibility(
                            visible: widget.ticket.count_tm_resiver! != "0" ? true : false,
                            child: Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: redColor, shape: BoxShape.circle),
                            child: Center(
                                child: Text(widget.ticket.count_tm_resiver!, style: TextStyle(color: Colors.white),)),
                          ))
                          
                        ]),
                        Text(
                            widget.ticket.name != null
                                ? widget.ticket.name!
                                : "Данное обращение не имеет имени.",
                            style: const TextStyle(fontSize: 17))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 19),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Дата",
                            style:
                                TextStyle(fontSize: 15, color: colorGrayClaim)),
                        Text("c ${widget.ticket.date_added!}",
                            style: const TextStyle(fontSize: 17))
                      ],
                    ),
                  ),
                  Status(
                    name: widget.ticket.cur_status != null
                        ? widget.ticket.cur_status!.name
                        : "",
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(17),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        widget.openChat!.call(widget.ticket);
                      },
                      child: Text("Открыть обращение", style: buttonTextStyle),
                      style: ElevatedButton.styleFrom(
                          primary: colorMain,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))))),
            )
          ],
        ),
      ),
    );
  }
}
