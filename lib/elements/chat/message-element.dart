import 'package:conres_app/elements/chat/preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import '../../model/message.dart';

class MessageElement extends StatelessWidget {
  dynamic message;
  void Function(String, String) fun;
  VoidCallback openBottomShitFunc;
  MessageElement({Key? key, required this.message, required this.fun, required this.openBottomShitFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isOwn! ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: message.isOwn! ? const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topLeft: Radius.circular(8)) : const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topLeft: Radius.circular(8)),
            color: message.isOwn! ? colorMain : messageColor),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Text(message.message!,
              style: TextStyle(
                  color: message.isOwn! ? Colors.white : Colors.black)),
          Visibility(
              visible: (message is TicketMessage)
                  ? (message.data != null ? true : false)
                  : false,
              child: GestureDetector(
                  onTap: () {
                    fun.call(
                        "${domain}lk/load_ticket_addit_file?link=${message.data!.file_href!}",
                        message.data!.document_name!);
                  },
                  child: SizedBox(
                      width: 150,
                      height: 120,
                      child: Flex(direction: Axis.vertical, children: [
                        Preview(
                            uri: message.data != null
                                ? (message.data!.thumb != null
                                    ? message.data!.thumb!
                                    : "")
                                : ""),
                        Flexible(
                          flex: 1,
                          child: Text(
                              message.data != null
                                  ? message.data!.document_name!
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: message.isOwn!
                                      ? Colors.white
                                      : Colors.black)),
                        )
                      ])))),
          Text("${message.date!.hour}:${message.date!.minute}", style: TextStyle(color:  message.isOwn! ? Colors.white : Colors.grey))
        ]),
      )
      );
    
    
  }
}
