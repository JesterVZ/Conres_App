import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:conres_app/UI/sliding-up-panel-page.dart';
import 'package:conres_app/chats/file-page.dart';
import 'package:conres_app/elements/chat/file-send-dialog.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/enums/chat-types.dart';
import 'package:conres_app/model/claim-message.dart';
import 'package:conres_app/model/message.dart';
import 'package:conres_app/websocket/claim-send.dart';
import 'package:conres_app/websocket/message-send.dart';
import 'package:conres_app/websocket/websocket-listener.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/alert.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/chat/file-for-send.dart';
import '../elements/chat/message-element.dart';

import '../websocket/message-read.dart';
import '../websocket/websocket.dart';

class MessagesPage<G, T> extends StatefulWidget {
  String userId;
  G? genericId; //id тикета или заявления
  T? type; //тип чата (из enum)
  Function? mainListener;
  String? page;
  String? statusName; //Открыт/Закрыт/В обработке и т.д
  MessagesPage(
      {required this.userId,
      required this.genericId,
      required this.page,
      required this.type,
      required this.statusName,
      required this.mainListener});
  @override
  State<StatefulWidget> createState() => _MessagesPage();
}

class _MessagesPage extends State<MessagesPage> {
  PanelController panelController =
      PanelController(); //контроллер выпадающей панели выбора файла или фото
  ProfileBloc? profileBloc;
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage; //полученная в результате съемки картинка
  List<Widget> messageFiles =
      []; // список файлов к сообщениям (отображение на панели)
  List<dynamic> messageList = []; //список сообщений (tickets)
  //List<ClaimMessage> claimMessageList = []; //список сообщений (claims)
  dynamic file; // файл, прикрепленный к сообщению
  bool isLoading = true; // если идет загрузка
  bool isLoadingMessages = true; //если идет загрузка сообщений
  bool isLoadingPage = true; //если идет подгрузка новой страницы
  bool isWaitForSend = false; // Ожидаем ли отправку сообщения
  WebSocketChannel? webSocketChannel; //канал веб-сокета
  WebSocketListener? webSocketListener; // какая именно функция слушает сокет
  WebSocketData? webSocketData; //Структура данных сокета
  String? lastMessageId; //id последнего сообщения
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  int page = 1; //номер страницы
  int messageCounter = 0;
  ReceivePort _receivePort = ReceivePort();
  String mainLabel = "";
  String? storeId;

  void _sendToastMessage(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _send() {
    isWaitForSend = true;
    if (widget.type == ChatTypes.Ticket) {
      profileBloc!.sendMessage(
          widget.genericId!, controller.text, widget.statusName!, file);
    } else if (widget.type == ChatTypes.Claim) {
      profileBloc!.sendClaimMessage(widget.genericId!, controller.text, file);
    }
  }

  void _openPicker() async {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        child: FilePage(),
      );
    });
  }

  void _loadImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        file = File(result.files[0].path!);
        messageFiles.clear();
        messageFiles.add(FileElement(
            filename: Path.basename(file.path),
            filepath: file.path,
            extension: Path.extension(file.path),
            func: () {
              setState(() {
                messageFiles.clear();
              });
            }));
      });
    }
  }

  void _loadImageFromUri(String uri, String fileName) async {
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
        if (widget.type == ChatTypes.Ticket) {
          isLoadingMessages = true;
          profileBloc!
              .getMessages(widget.genericId!, page.toString(), lastMessageId!);
        }
      });
    }
  }

  void editMessage(){

  }

  void deleteMessage(){

  }

  void copyMessage(String message){

  }

  void openBottomShit(){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/copy.svg'),
                Text("Скопировать")
              ],
            )
          ],
        )
      );
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
                      backgroundColor: Colors.white,
                      body: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                  height: 100,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: HeaderNotification(
                                          text:
                                              "$mainLabel № ${widget.genericId}",
                                          canGoBack: true))),
                              Expanded(
                                //сюда сообщения
                                child: Scrollbar(
                                  child: ListView.builder(
                                      itemCount: messageList.length,
                                      controller: scrollController,
                                      reverse: true,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return MessageElement(
                                            openBottomShitFunc: openBottomShit,
                                            message: messageList[i],
                                            fun: _loadImageFromUri);
                                      }),
                                ),
                              ),
                              Stack(
                                children: [
                                  Visibility(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        height: 70,
                                        child: SingleChildScrollView(
                                            child: Row(children: messageFiles),
                                            scrollDirection: Axis.horizontal),
                                      ),
                                      visible: ((file == null ||
                                              messageFiles.isEmpty)
                                          ? false
                                          : true)), //панель для файлов
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                alignment: Alignment.topCenter,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 18, right: 18, top: 13),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              //_loadImage();
                                              //_openDialog();
                                              _openPicker();
                                            },
                                            child: SvgPicture.asset(
                                                'assets/clip.svg')),
                                        const Spacer(),
                                        SizedBox(
                                          width: 245,
                                          child: TextField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            controller: controller,
                                            decoration: InputDecoration(
                                              hintText: "Сообщение...",
                                              fillColor: messageColor,
                                              filled: true,
                                              border: InputBorder.none,
                                            ),
                                            minLines: 1,
                                            maxLines: 5,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            if (isWaitForSend == false) {
                                              _send();
                                            }
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
                                              child: isWaitForSend == true
                                                  ? const CircularProgressIndicator(
                                                      color: Colors.white,
                                                    )
                                                  : SvgPicture.asset(
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
                                child: CircularProgressIndicator(color: colorMain),
                              )),
                              visible:
                                  (isLoadingMessages == true) ? true : false)
                        ],
                      ));
            
            }));
  }

  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading!;
    if (state.error != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Ошибка", text: state.error!));
    }
    if (state.ticketFullInfo != null && mainLabel == "Обращение") {
      isLoadingMessages = false;
      lastMessageId = state.ticketFullInfo!.last_message_id!;

      if (page == 1) {
        messageList = state.ticketFullInfo!.messages!;
        readMessage(widget.genericId!, lastMessageId!);
        for (int i = 0; i < state.ticketFullInfo!.messages!.length; i++) {
          messageList[i].isOwn =
              state.ticketFullInfo!.messages![i].user_id != widget.userId
                  ? false
                  : true;
        }
      }

      if ((int.parse(state.page!) == page) && page > 1) {
        //если страница текущая
        messageList = state.ticketFullInfo!.messages! +
            (messageList as List<TicketMessage>);
        for (int i = 0; i < state.ticketFullInfo!.messages!.length; i++) {
          messageList[i].isOwn =
              state.ticketFullInfo!.messages![i].user_id != widget.userId
                  ? false
                  : true;
        }
      }
      messageList.sort((a, b) {
        return int.parse(b.ticket_message_id!)
            .compareTo(int.parse(a.ticket_message_id!));
      });
    }
    if (state.claimMessages != null && mainLabel == "Заявление") {
      isLoadingMessages = false;
      messageList = state.claimMessages!;
      for (int i = 0; i < state.claimMessages!.length; i++) {
        messageList[i].isOwn =
            state.claimMessages![i].user_id != widget.userId ? false : true;
      }
      messageList.sort((a, b) {
        return int.parse(b.claim_message_id!)
            .compareTo(int.parse(a.claim_message_id!));
      });
    }
    if (state.sendMessageData != null) {
      //если пришел ответ api по отправке сообщения
      isWaitForSend = false;
      dynamic message; //Это данные для отправки в сокет
      if (widget.type == ChatTypes.Ticket) {
        message = MessageSend(
            cmd: "publish",
            subject: "store-${store_id}",
            event: "ticket_msg",
            data: MessageSendData(
                user_type: "lk",
                user_id: int.parse(widget.userId),
                files: state.sendMessageData!['ticket_message_files'],
                ticket_id: int.parse(widget.genericId!),
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
      } else if (widget.type == ChatTypes.Claim) {
        message = ClaimSend(
            cmd: "publish",
            subject: "store-${store_id}",
            event: "claim_msg",
            data: ClaimSendData(
                user_type: "lk",
                user_id: int.parse(widget.userId),
                files: state.sendMessageData!['data']['claim_message_files'],
                claim_id: int.parse(state.sendMessageData!['data']['claim_info']
                    [0]['claim_id']),
                claim_info: [
                  ClaimInfo(
                      claim_message_id: state.sendMessageData!['data']
                          ['claim_info'][0]['claim_message_id'],
                      claim_id: state.sendMessageData!['data']['claim_info'][0]
                          ['claim_id'],
                      message: state.sendMessageData!['data']['claim_info'][0]
                          ['message'],
                      data: state.sendMessageData!['data']['claim_info'][0]
                          ['data'],
                      date: state.sendMessageData!['data']['claim_info'][0]
                          ['date'],
                      attachments: state.sendMessageData!['data']['claim_info']
                          [0]['attachments'],
                      message_id: state.sendMessageData!['data']['claim_info']
                          [0]['message_id'],
                      user_type: state.sendMessageData!['data']['claim_info'][0]
                          ['user_type'],
                      claims_status_id: state.sendMessageData!['data']
                          ['claim_info'][0]['claims_status_id'],
                      model_user: state.sendMessageData!['data']['claim_info']
                          [0]['model_user'],
                      user_id: state.sendMessageData!['data']['claim_info'][0]
                          ['user_id'],
                      user_name: state.sendMessageData!['data']['claim_info'][0]
                          ['user_name'],
                      date_added: state.sendMessageData!['data']['claim_info'][0]['date_added'],
                      text: state.sendMessageData!['data']['claim_info'][0]['text'],
                      last_claim_lk: state.sendMessageData!['data']['claim_info'][0]['last_claim_lk'],
                      files: state.sendMessageData!['data']['claim_info'][0]['files'])
                ],
                user_info: UserInfo(
                    inn: state.sendMessageData!['data']['user_info']['inn'],
                    firstname: state.sendMessageData!['data']['user_info']
                        ['firstname'],
                    lastname: state.sendMessageData!['data']['user_info']
                        ['lastname'],
                    patronymic: state.sendMessageData!['data']['user_info']
                        ['patronymic'],
                    contacts: Contacts(
                        phone: state.sendMessageData!['data']['user_info']
                            ['contacts']['2'],
                        email: state.sendMessageData!['data']['user_info']
                            ['contacts']['3']),
                    href: state.sendMessageData!['data']['user_info']['href']),
                date_group: state.sendMessageData!['data']['date_group'],
                date_group_name: state.sendMessageData!['data']
                    ['date_group_name']),
            to_id: int.parse(widget.userId));
      }

      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
      //_sendToastMessage(context, "send $data");
      controller.text = "";
      setState(() {
        if (widget.type == ChatTypes.Ticket) {
          if (state.sendMessageData!['ticket_info'][0]['files'].isNotEmpty) {
            //если файлы в сообщении были
            messageFiles.clear();
            file = null;
            profileBloc!.getMessages(widget.genericId!, widget.page!,
                lastMessageId!); //взять сообщения еще раз
          }

          messageList.add(TicketMessage(
              isOwn: true,
              date: DateTime.parse(
                  state.sendMessageData!['ticket_info'][0]['date_added']),
              ticket_message_id: state.sendMessageData!['ticket_info'][0]
                  ['ticket_message_id'],
              ticket_id: state.sendMessageData!['ticket_info'][0]['ticket_id'],
              message_id: state.sendMessageData!['ticket_info'][0]
                  ['ticket_message_id'],
              message: state.sendMessageData!['ticket_info'][0]['message'],
              ticket_status_type_id: state.sendMessageData!['ticket_info'][0]
                  ['ticket_status_type_id'],
              model_user: state.sendMessageData!['ticket_info'][0]
                  ['model_user'],
              user_id: state.sendMessageData!['ticket_info'][0]['user_id'],
              user_name: state.sendMessageData!['ticket_info'][0]['user_name'],
              name: state.sendMessageData!['ticket_info'][0]['name'],
              color_type_id: state.sendMessageData!['ticket_info'][0]
                  ['color_type_id'],
              date_group: state.sendMessageData!['date_group'],
              last_tm_resiver: state.sendMessageData!['ticket_info'][0]
                  ['last_tm_resiver']));
          messageList.sort((a, b) {
            return int.parse(b.ticket_message_id!)
                .compareTo(int.parse(a.ticket_message_id!));
          });
        } else if (widget.type == ChatTypes.Claim) {
          if (state
              .sendMessageData!['data']['claim_info'][0]['files'].isNotEmpty) {
            messageFiles.clear();
            file = null;
            profileBloc!.getClaimMessages(widget.genericId!);
            //profileBloc!.getMessages(widget.genericId!, widget.page!, lastMessageId!);
          } //под вопросом!!!

          messageList.add(ClaimMessage(
              isOwn: true,
              claim_message_id: state.sendMessageData!['data']['claim_info'][0]
                  ['claim_message_id'],
              claim_id: state.sendMessageData!['data']['claim_info'][0]
                  ['claim_id'],
              date: DateTime.parse(state.sendMessageData!['data']['claim_info']
                  [0]['date_added']),
              //data: state.sendMessageData!['data']['claim_info'][0]['attachments'],
              data: null,
              claims_status_id: state.sendMessageData!['data']['claim_info'][0]
                  ['claims_status_id'],
              message: state.sendMessageData!['data']['claim_info'][0]
                  ['message'],
              user_id: state.sendMessageData!['data']['claim_info'][0]
                  ['user_id'],
              user_name: state.sendMessageData!['data']['claim_info'][0]
                  ['user_name'],
              user_type: "lk"));
          messageList.sort((a, b) {
            return int.parse(b.claim_message_id!)
                .compareTo(int.parse(a.claim_message_id!));
          });
        }
      });
    }
  }

  void readMessage(String genericId, String messageId) {
    MessageRead messageRead = MessageRead(
        cmd: 'publish',
        event: 'ticket_msg_read',
        subject: 'store-${store_id}',
        to_id: int.parse(widget.userId),
        data: MessageReadData(
            message_id: messageId,
            ticket_id: int.parse(genericId),
            user_id: int.parse(widget.userId),
            user_type: "lk"));
    String data = jsonEncode(messageRead.toJson());
    webSocketChannel!.sink.add(data);
    profileBloc!.readMessage(genericId, messageId);
  }

  void getData(dynamic event) async {
    print('\x1B[32m$event\x1B[0m');
    // _sendToastMessage(context, "got $event");
    if (isLoading == false) {
      if (widget.type == ChatTypes.Ticket) {
        profileBloc!
            .getMessages(widget.genericId!, widget.page!, lastMessageId!);
      } else if (widget.type == ChatTypes.Claim) {
        profileBloc!.getClaimMessages(widget.genericId!);
      }
    }
  }

  @override
  void dispose() {
    print("Dispose");
    webSocketListener!.function = widget.mainListener;
    super.dispose();
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
    isLoadingMessages = true;

    if (widget.type == ChatTypes.Ticket) {
      profileBloc!.getMessages(widget.genericId!, widget.page!,
          lastMessageId != null ? lastMessageId! : "1");
      mainLabel = "Обращение";
    } else if (widget.type == ChatTypes.Claim) {
      profileBloc!.getClaimMessages(widget.genericId!);
      mainLabel = "Заявление";
    }
  }
}
