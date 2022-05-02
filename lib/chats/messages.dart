import 'dart:convert';

import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/message.dart';
import 'package:conres_app/websocket/message-send.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/chat/mesage-row.dart';
import '../model/profile.dart';

class MessagesPage extends StatefulWidget {
  String userId;
  String? ticketId;
  String? page;
  String? lastMessageId;
  String? userName;
  Profile? profile;
  MessagesPage(
      {required this.userId,
      required this.ticketId,
      required this.page,
      required this.lastMessageId,
      required this.profile});
  @override
  State<StatefulWidget> createState() => _MessagesPage();
}

class _MessagesPage extends State<MessagesPage> {
  ProfileBloc? profileBloc;
  List<Widget> messagesList = [];
  List<String> fio = [];
  bool isLoading = true;
  WebSocketChannel? webSocketChannel;
  String lastId = "";
  TextEditingController controller = TextEditingController();
  void _send() {
    setState(() {
      messagesList.add(MessageRow(text: controller.text, isOwn: true));
      List<dynamic> files = [];
      int messageId = int.parse(widget.lastMessageId!);
      MessageSend message = MessageSend(
          cmd: "publish",
          subject: "store-3",
          event: "ticket_msg",
          data: Data(
              user_type: "lk",
              user_id: int.parse(widget.userId),
              files: files,
              ticket_id: int.parse(widget.ticketId!),
              ticket_info: [
                TicketInfo(
                    ticket_message_id: (int.parse(lastId) + 1).toString(),
                    ticket_id: widget.ticketId,
                    message: controller.text,
                    data: "",
                    ticket_status_type_id: "5",
                    model_user: "user_lk",
                    user_id: widget.userId,
                    user_name: widget.profile?.userName!,
                    date_added: DateTime.now().toString(),
                    name: "Открыт",
                    color_type_id: "3",
                    last_tm_resiver: widget.ticketId,
                    files: [])
              ],
              user_info: UserInfo(
                  inn: widget.profile?.inn,
                  firstname: fio[0],
                  lastname: fio[1],
                  patronymic: fio[2],
                  contacts: "",
                  href:
                      "index.php?route=user/user_lk/edit&user_lk_id=${widget.userId}"),
              date_group: DateTime.now().toString(),
              date_group_name: ""),
          to_id: int.parse(widget.userId));
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
      controller.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocScreen<ProfileBloc, ProfileState>(
            bloc: profileBloc,
            listener: (context, state) => _listener(context, state),
            builder: (context, state) {
              return Scaffold(
                  body: Stack(
                children: [
                  Visibility(
                      child: Center(
                          child: Container(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/loading.gif'),
                      )),
                      visible: isLoading),
                  Column(
                    children: [
                      Container(
                          height: 100,
                          child: HeaderNotification(text: "Сообщения")),
                      Expanded(
                          child: Scrollbar(
                              child: SingleChildScrollView(
                                  child: Column(
                        children: [
                          Column(
                            children: [
                              //здесь сообщения
                              Column(
                                children: messagesList,
                              ),
                            ],
                          )
                        ],
                      )))),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: Padding(
                            padding: EdgeInsets.only(left: 18, right: 18),
                            child: Row(
                              children: [
                                GestureDetector(
                                    child: SvgPicture.asset('assets/clip.svg')),
                                const Spacer(),
                                Container(
                                  width: 245,
                                  child: TextField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                        hintText: "Сообщение...",
                                        fillColor: messageColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    _send();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(14),
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorMain,
                                    ),
                                    child: Container(
                                      width: 18,
                                      height: 14,
                                      child: SvgPicture.asset(
                                          'assets/arrow-type2.svg'),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ],
              ));
            }));
  }

  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading!;
    if (state.loading == true) {
      return;
    }
    if (state.messages != null) {
      lastId = state.messages!.last.message_id!;
      if (messagesList.isEmpty) {
        for (int i = 0; i < state.messages!.length; i++) {
          messagesList.add(MessageRow(
              text: state.messages![i].message!,
              isOwn:
                  state.messages![i].user_id != widget.userId ? false : true));
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel;
    fio = widget.profile!.userName!.split(" ");
    profileBloc!
        .getMessages(widget.ticketId!, widget.page!, widget.lastMessageId!);
  }
}
