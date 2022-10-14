import 'dart:io';

import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../websocket/websocket.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class GetCookieStrEvent extends ProfileEvent{
  List cookies;
  GetCookieStrEvent(this.cookies);
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
  final String page;
  const GetTickets(this.page);
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
  final dynamic file;
  const SendMessageEvent(this.ticket_id, this.message, this.ticket_status_id, this.file);
}

class EditMessageEvent extends ProfileEvent{
  //ticket_status_id: Открыт/Закрыт/В обработке
  final String ticket_id;
  final String message;
  final String ticket_status_id;
  final dynamic file;
  const EditMessageEvent(this.ticket_id, this.message, this.ticket_status_id, this.file);
}


class SendClaimMessageEvent extends ProfileEvent{
  final String claim_id;
  final String text;
  final dynamic file;
  const SendClaimMessageEvent(this.claim_id, this.text, this.file);
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

class GetObjectsPU extends ProfileEvent{
  const GetObjectsPU();
}

class GetFullProfileInfo extends ProfileEvent{
  const GetFullProfileInfo();
}

class GetTU extends ProfileEvent{
  const GetTU();
}

class CreateNewTicket extends ProfileEvent{
  String contact_email;
  String contact_name;
  String ticket_theme_id;
  String message;
  CreateNewTicket(this.contact_email, this.contact_name, this.message, this.ticket_theme_id);
}

class GetClaimMessages extends ProfileEvent{
  String claim_id;
  GetClaimMessages(this.claim_id);
}

class GetAllPhotos extends ProfileEvent{
  Album album;
  GetAllPhotos(this.album);
}

class SendBaseClaim extends ProfileEvent{
  String claim_type_id;
  String claim_template;
  String claim_type;
  String claim_name;
  String field_header_whom_1;
  String field_phone;
  String field_email;
  String field_content_date;
  String field_header_who;
  String field_header_egrul;
  String field_header_address_1;
  String field_header_address_2;
  String field_header_egrul_date;
  String field_content_main;
  String claim_operator_email;
  SendBaseClaim(this.claim_type_id, this.claim_template, this.claim_name, this.claim_type, this.claim_operator_email, this.field_content_date, this.field_content_main, this.field_email, this.field_header_address_1, this.field_header_address_2, this.field_header_egrul, this.field_header_egrul_date, this.field_header_who, this.field_header_whom_1, this.field_phone);
}