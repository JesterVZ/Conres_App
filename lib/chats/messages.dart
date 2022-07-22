import 'dart:convert';
import 'dart:isolate';

import 'package:conres_app/elements/chat/file-send-dialog.dart';
import 'package:conres_app/elements/chat/preview.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/message.dart';
import 'package:conres_app/websocket/message-send.dart';
import 'package:conres_app/websocket/websocket-listener.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/alert.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/chat/file-for-send.dart';
import '../model/profile.dart';

import '../websocket/websocket.dart';

class MessagesPage extends StatefulWidget {
  String userId;
  String? ticketId;
  String? page;
  String? statusName; //Открыт/Закрыт/В обработке и т.д
  Profile? profile;
  MessagesPage(
      {required this.userId,
      required this.ticketId,
      required this.page,
      required this.profile,
      required this.statusName});
  @override
  State<StatefulWidget> createState() => _MessagesPage();
}

class _MessagesPage extends State<MessagesPage> {
  ProfileBloc? profileBloc;
  List<Widget> messageFiles = []; // список файлов к сообщениям (отображение на панели)
  List<TicketMessage> messageList = []; //список сообщений
  List<PlatformFile>? files; // список файлов к сообщениям
  bool isLoading = true; // если идет загрузка
  WebSocketChannel? webSocketChannel; //канал веб-сокета
  WebSocketListener? webSocketListener; // какая именно функция слушает сокет
  WebSocketData? webSocketData; //Структура данных сокета
  String? lastMessageId;
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  int page = 1;
  int messageCounter = 0;
  ReceivePort _receivePort = ReceivePort();

  void _send() {
    profileBloc!
        .sendMessage(widget.ticketId!, controller.text, widget.statusName!, files);
  }
  void _createPhoto(){
    
  }
  void _openDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) => FileSendDialog(pickFile: _loadImage, createPhoto: _createPhoto));
  }
  void _loadImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        files = result.files;
        for(int i = 0; i < result.files.length; i++){
          messageFiles.add(FileElement(filename: result.files[i].name));
        }
      });
    }
  }
  void _loadImageFromUri(String uri, String fileName) async{
    final externalDir = await getExternalStorageDirectory();
    final status = await Permission.storage.request();
    profileBloc!.downloadFile(uri, fileName);

  }

  @override
  void initState() {
    page = int.parse(widget.page!);
    scrollController.addListener(pagination);
    super.initState();

  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        page++;
        profileBloc!.getMessages(widget.ticketId!, page.toString(), lastMessageId!);
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
                  Column(
                    children: [
                      Container( 
                          height: 100,
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: HeaderNotification(
                                  text: "Обращение № ${widget.ticketId}", canGoBack: true))),
                      
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(itemCount: messageList.length, controller: scrollController, reverse: true, itemBuilder: (BuildContext context, int i) {
                            return Align(
                            alignment: messageList[i].isOwn!
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        messageList[i].isOwn! ? colorMain : messageColor),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                child: Column(children: [
                                  Text("${messageList[i].message!}",
                                      style: TextStyle(
                                          color: messageList[i].isOwn!
                                              ? Colors.white
                                              : Colors.black)),
                                  //Text(messageList[i].date_added.toString()), 
                                  //Text("${message.message_id}"), //message id
                                  Visibility(
                                      visible: messageList[i].data != null ? true : false,
                                      child: GestureDetector(
                                          onTap: () {
                                            _loadImageFromUri("${domain}lk/load_ticket_addit_file?link=${messageList[i].data!.file_href!}", messageList[i].data!.document_name!);
                                          },
                                          child: 
                                          SizedBox(
                                            width: 150,
                                            height: 120,
                                            child: Flex(direction: Axis.vertical,children: [
                                            Preview(uri: messageList[i].data != null ?(messageList[i].data!.thumb != null ? messageList[i].data!.thumb! : "") : ""),
                                            
                                            Flexible(
                                                    flex: 1,
                                                    child: Text(
                                                            messageList[i].data != null
                                                              ? messageList[i].data!.document_name!
                                                              : "",
                                                              overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration.underline,
                                                              color: messageList[i].isOwn! ? Colors.white : Colors.black)),        
                                                  )
                                          ])))
                                  )
                                ]),
                              ),
                          );
                          } ),
                        ),
                      ),
                      Stack(
                        children: [
                          Visibility(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 70,
                              child: SingleChildScrollView(child: Row(children: messageFiles), scrollDirection: Axis.horizontal),
                              ), visible: (files == null || files!.isEmpty) ? false : true), //панель для файлов
                          
                        ],
                      ),
                      
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: Padding(
                            padding: EdgeInsets.only(left: 18, right: 18),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    //_loadImage();
                                    _openDialog();
                                    },
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
                  Visibility(
                      child: Center(
                          child: Container(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/loading.gif'),
                      )),
                      visible: isLoading)
                ],
              ));
            }));
  }

  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading!;
    if(state.error != null) {
      showDialog(
            context: context,
            builder: (BuildContext context) => Alert(
                title: "Ошибка",
                text: state.error!));
    }
    if (state.ticketFullInfo != null) {
      lastMessageId = state.ticketFullInfo!.last_message_id!;
    if(page == 1){
      messageList = state.ticketFullInfo!.messages!;
        profileBloc!.readMessage(widget.ticketId!, lastMessageId!);
        for (int i = 0; i < state.ticketFullInfo!.messages!.length; i++) {
          messageList[i].isOwn =
              state.ticketFullInfo!.messages![i].user_id != widget.userId ? false : true;
        }
    }

      if ((int.parse(state.page!) == page) && page > 1) { //если страница текущая
        messageList = state.ticketFullInfo!.messages! + messageList;
        for (int i = 0; i < state.ticketFullInfo!.messages!.length; i++) {
          messageList[i].isOwn =
              state.ticketFullInfo!.messages![i].user_id != widget.userId ? false : true;
        }
      }
      messageList.sort((a, b) {
          return b.date_added!.compareTo(a.date_added!);
      });
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
                    ticket_message_id: state.sendMessageData!['ticket_info'][0]
                        ['ticket_message_id'],
                    ticket_id: state.sendMessageData!['ticket_info'][0]
                        ['ticket_id'],
                    message: state.sendMessageData!['ticket_info'][0]
                        ['message'],
                    data: state.sendMessageData!['ticket_info'][0]['data'],
                    ticket_status_type_id: state.sendMessageData!['ticket_info']
                        [0]['ticket_status_type_id'],
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
                  patronymic: state.sendMessageData!['user_info']['patronymic'],
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
      if(state.sendMessageData!['ticket_info'][0]['files'] != null){
        messageFiles.clear();
        files = null;
        profileBloc!.getMessages(widget.ticketId!, widget.page!, lastMessageId!);
      }
        messageList.add(TicketMessage(
            isOwn: true,
            date_added: DateTime.parse(
                state.sendMessageData!['ticket_info'][0]['date_added']),
            ticket_message_id: state.sendMessageData!['ticket_info'][0]
                ['ticket_message_id'],
            ticket_id: state.sendMessageData!['ticket_info'][0]['ticket_id'],
            message_id: null,
            
            message: state.sendMessageData!['ticket_info'][0]['message'],
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
      messageList.sort((a, b) {
        return b.date_added!.compareTo(a.date_added!);
      });       
      });
    }
  }

  void getData(dynamic event) async {
    if (isLoading == false) {
      profileBloc!.getMessages(widget.ticketId!, widget.page!, lastMessageId!);
    }
    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel;
    webSocketListener ??= DependencyProvider.of(context)!.webSocketListener;
    webSocketData ??= DependencyProvider.of(context)!.webSocketData;
    webSocketListener?.webSocketChannel = webSocketChannel;
    webSocketListener?.function = getData;
    profileBloc!
        .getMessages(widget.ticketId!, widget.page!, lastMessageId != null ? lastMessageId! : "1");
    
  }
}
