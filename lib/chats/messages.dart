import 'dart:convert';

import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/message.dart';
import 'package:conres_app/websocket/message-send.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/chat/mesage-row.dart';
import '../model/profile.dart';
import 'package:intl/intl.dart';

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
  List<TicketMessage> pagesMessageList = [];
  List<String> fio = [];
  bool isLoading = true;
  WebSocketChannel? webSocketChannel;
  String lastId = "";
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  int page = 1;
  void _send() {
    profileBloc!.sendMessage(widget.ticketId!, controller.text, "Открыт");
  }
  @override
  void initState() {
    page = int.parse(widget.page!);
    scrollController.addListener(pagination);
    super.initState();
  }
  void pagination(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      setState(() {
        page++;
        profileBloc!.getMessages(widget.ticketId!, page.toString(), widget.lastMessageId!);
      });
    }
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child:  HeaderNotification(text: "Сообщения"))),
                      Expanded(
                          child: GroupedListView<TicketMessage, DateTime>(
                            controller: scrollController,
                        order: GroupedListOrder.DESC,
                        reverse: true,
                        useStickyGroupSeparators: true,
                        floatingHeader: true,
                        elements: pagesMessageList,
                        groupBy: (message) => DateTime(message.date_added!.year,
                            message.date_added!.month, message.date_added!.day),
                        groupHeaderBuilder: (TicketMessage message) => Text(
                                DateFormat.yMMMd().format(message.date_added!),
                                style: TextStyle(color: claimLabelColor), textAlign: TextAlign.center),
                        itemBuilder: (context, TicketMessage message) => Align(
                          alignment: message.isOwn!
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    message.isOwn! ? colorMain : messageColor),
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            child: Text(message.message!,
                                style: TextStyle(
                                    color: message.isOwn!
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),
                      )),
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
      if (pagesMessageList.isEmpty) {
        pagesMessageList = state.messages!;
        for (int i = 0; i < state.messages!.length; i++) {
          pagesMessageList[i].isOwn =
              state.messages![i].user_id != widget.userId ? false : true;
        }
      }
      if(page > 1){
          pagesMessageList = state.messages! + pagesMessageList;
          for (int i = 0; i < state.messages!.length; i++) {
          pagesMessageList[i].isOwn =
              state.messages![i].user_id != widget.userId ? false : true;
        }
      }
    }
    if (state.sendMessageData != null) {
        MessageSend message = MessageSend(
            cmd: "publish",
            subject: "store-3",
            event: "ticket_msg",
            data: Data(
                user_type: "lk",
                user_id: int.parse(widget.userId),
                files: state.sendMessageData!['ticket_message_files'],
                ticket_id: int.parse(widget.ticketId!),
                ticket_info: [
                  TicketInfo(
                      ticket_message_id: state.sendMessageData!['ticket_info']
                          [0]['ticket_message_id'],
                      ticket_id: state.sendMessageData!['ticket_info'][0]
                          ['ticket_id'],
                      message: state.sendMessageData!['ticket_info'][0]
                          ['message'],
                      data: state.sendMessageData!['ticket_info'][0]['data'],
                      ticket_status_type_id:
                          state.sendMessageData!['ticket_info'][0]
                              ['ticket_status_type_id'],
                      model_user: state.sendMessageData!['ticket_info'][0]
                          ['model_user'],
                      user_id: state.sendMessageData!['ticket_info'][0]
                          ['user_id'],
                      user_name: state.sendMessageData!['ticket_info'][0]
                          ['user_name'],
                      date_added: state.sendMessageData!['ticket_info'][0]
                          ['date_added'],
                      name: state.sendMessageData!['ticket_info'][0]['name'],
                      color_type_id: state.sendMessageData!['ticket_info'][0]
                          ['color_type_id'],
                      last_tm_resiver: state.sendMessageData!['ticket_info'][0]
                          ['last_tm_resiver'],
                      files: state.sendMessageData!['ticket_info'][0]['files'])
                ],
                user_info: UserInfo(
                    inn: state.sendMessageData!['user_info']['inn'],
                    firstname: state.sendMessageData!['user_info']['firstname'],
                    lastname: state.sendMessageData!['user_info']['lastname'],
                    patronymic: state.sendMessageData!['user_info']
                        ['patronymic'],
                    contacts: Contacts(
                        phone: state.sendMessageData!['user_info']['contacts']
                            ['2'],
                        email: state.sendMessageData!['user_info']['contacts']
                            ['3']),
                    href: state.sendMessageData!['user_info']['href']),
                date_group: state.sendMessageData!['date_group'],
                date_group_name: state.sendMessageData!['date_group_name']),
            to_id: int.parse(widget.userId));
        String data = jsonEncode(message.toJson());
        webSocketChannel!.sink.add(data);
        controller.text = "";
      setState(() {
        pagesMessageList.add(TicketMessage(
          isOwn: true,
            date_added: DateTime.parse(state.sendMessageData!['ticket_info'][0]['date_added']),
            ticket_message_id: state.sendMessageData!['ticket_info'][0]
                ['ticket_message_id'],
            ticket_id: state.sendMessageData!['ticket_info'][0]['ticket_id'],
            message_id: null,
            message: state.sendMessageData!['ticket_info'][0]['message'],
            data: state.sendMessageData!['ticket_info'][0]['data'],
            ticket_status_type_id: state.sendMessageData!['ticket_info'][0]
                ['ticket_status_type_id'],
            model_user: state.sendMessageData!['ticket_info'][0]['model_user'],
            user_id: state.sendMessageData!['ticket_info'][0]['user_id'],
            user_name: state.sendMessageData!['ticket_info'][0]['user_name'],
            
            name: state.sendMessageData!['ticket_info'][0]['name'],
            color_type_id: state.sendMessageData!['ticket_info'][0]
                ['color_type_id'],
            date_group: state.sendMessageData!['date_group'],
            last_tm_resiver: state.sendMessageData!['ticket_info'][0]
                ['last_tm_resiver']));
      });
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
