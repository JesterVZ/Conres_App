import 'package:equatable/equatable.dart';

import '../../websocket/websocket.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class GetCookieStrEvent extends ProfileEvent{
  final String username;
  final String password;
  final int type;
  const GetCookieStrEvent(this.username, this.password, this.type);
}

class GetLoginData extends ProfileEvent{
  const GetLoginData();
}

class GetWebSocketData extends ProfileEvent{
  final WebSocketData webSocketData;
  const GetWebSocketData(this.webSocketData);
}

class LogoutEvent extends ProfileEvent{
  const LogoutEvent();
}

class BindNewLS extends ProfileEvent{
  final String number;
  final String address;
  const BindNewLS(this.number, this.address);
}

class GetContracts extends ProfileEvent{
  const GetContracts();
}

class GetAllInfo extends ProfileEvent{
  const GetAllInfo();
}

class GetClaims extends ProfileEvent{
  const GetClaims();
}

class GetTickets extends ProfileEvent{
  const GetTickets();
}

class GetMessages extends ProfileEvent{
  final String chat_id;
  final String page;
  final String last_message_id;
  const GetMessages(this.chat_id, this.page, this.last_message_id);
}

class SendMessageEvent extends ProfileEvent{
  //ticket_status_id: Открыт/Закрыт/В обработке
  final String ticket_id;
  final String message;
  final String ticket_status_id;
  const SendMessageEvent(this.ticket_id, this.message, this.ticket_status_id);
}

class ReadMessage extends ProfileEvent{
  String ticketId;
  String messageId;
  ReadMessage(this.ticketId, this.messageId);
}

class DownloadFile extends ProfileEvent{
  String uri;
  String filename;
  DownloadFile(this.uri, this.filename);
}