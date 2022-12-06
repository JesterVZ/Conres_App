import 'dart:io';

import 'package:conres_app/Services/main-claim-send-service.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../Services/base-claim-send-service.dart';
import '../../websocket/websocket.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class GetCookieStrEvent extends ProfileEvent {
  List cookies;
  GetCookieStrEvent(this.cookies);
}

class GetLoginData extends ProfileEvent {
  const GetLoginData();
}

class GetWebSocketData extends ProfileEvent {
  final WebSocketData webSocketData;
  const GetWebSocketData(this.webSocketData);
}

class LogoutEvent extends ProfileEvent {
  const LogoutEvent();
}

class BindNewLS extends ProfileEvent {
  final String number;
  final String address;
  const BindNewLS(this.number, this.address);
}

class GetContracts extends ProfileEvent {
  const GetContracts();
}

class GetAllInfo extends ProfileEvent {
  const GetAllInfo();
}

class GetClaims extends ProfileEvent {
  const GetClaims();
}

class GetTickets extends ProfileEvent {
  final String page;
  const GetTickets(this.page);
}

class GetMessages extends ProfileEvent {
  final String chat_id;
  final String page;
  final String last_message_id;
  const GetMessages(this.chat_id, this.page, this.last_message_id);
}

class SendMessageEvent extends ProfileEvent {
  //ticket_status_id: Открыт/Закрыт/В обработке
  final String ticket_id;
  final String message;
  final String ticket_status_id;
  final dynamic file;
  const SendMessageEvent(
      this.ticket_id, this.message, this.ticket_status_id, this.file);
}

class EditMessageEvent extends ProfileEvent {
  //ticket_status_id: Открыт/Закрыт/В обработке
  final String ticket_id;
  final String message;
  final String ticket_status_id;
  final dynamic file;
  const EditMessageEvent(
      this.ticket_id, this.message, this.ticket_status_id, this.file);
}

class SendClaimMessageEvent extends ProfileEvent {
  final String claim_id;
  final String text;
  final dynamic file;
  const SendClaimMessageEvent(this.claim_id, this.text, this.file);
}

class ReadMessage extends ProfileEvent {
  String ticketId;
  String messageId;
  ReadMessage(this.ticketId, this.messageId);
}

class ReadClaimMessage extends ProfileEvent{
  String claimId;
  String messageId;
  ReadClaimMessage(this.claimId, this.messageId);
}

class DownloadFile extends ProfileEvent {
  String uri;
  String filename;
  DownloadFile(this.uri, this.filename);
}

class GetObjectsPU extends ProfileEvent {
  const GetObjectsPU();
}

class GetFullProfileInfo extends ProfileEvent {
  const GetFullProfileInfo();
}

class GetTU extends ProfileEvent {
  const GetTU();
}

class CreateNewTicket extends ProfileEvent {
  String contact_email;
  String contact_name;
  String ticket_theme_id;
  String message;
  CreateNewTicket(this.contact_email, this.contact_name, this.message,
      this.ticket_theme_id);
}

class GetClaimMessages extends ProfileEvent {
  String claim_id;
  GetClaimMessages(this.claim_id);
}

class GetAllPhotos extends ProfileEvent {
  Album album;
  GetAllPhotos(this.album);
}

class SendBaseClaim extends ProfileEvent {
  BaseClaimSendService baseClaimSendService;
  SendBaseClaim(this.baseClaimSendService);
}

class SendMainClaim extends ProfileEvent {
  MainClaimSendService mainClaimSendService;
  SendMainClaim(this.mainClaimSendService);
}

class GetTuPoints extends ProfileEvent {
  const GetTuPoints();
}

class GetPrivatePolicy extends ProfileEvent {
  const GetPrivatePolicy();
}

class SendTestimonyEvent extends ProfileEvent {
  List<String> dayValues = [];
  List<String> nightValues = [];
  SendTestimonyEvent(this.dayValues, this.nightValues);
}

class SetCounters extends ProfileEvent {
  int ticketCounter;
  int claimCounter;
  SetCounters(this.ticketCounter, this.claimCounter);
}

class EditObject extends ProfileEvent {
  String id;
  String name;
  String address;
  EditObject(this.id, this.name, this.address);
}

class EditTu extends ProfileEvent {
  String id;
  String number;
  String name;
  String address;
  EditTu(this.id, this.number, this.name, this.address);
}

class HiddenAccountRequest extends ProfileEvent {
  String account_id;
  HiddenAccountRequest(this.account_id);
}

class HiddenObjectRequest extends ProfileEvent{
  String object_id;
  HiddenObjectRequest(this.object_id);
}

class HidenTuRequest extends ProfileEvent{
  String point_id;
  HidenTuRequest(this.point_id);
}

class BindNewObject extends ProfileEvent{
  String objectName; 
  String objectAddress;
  BindNewObject(this.objectName, this.objectAddress);
}

class BindNewTU extends ProfileEvent{
  String object_id;
  String new_tu_number;
  String new_tu_name;
  String new_tu_address;
  BindNewTU(this.object_id, this.new_tu_number, this.new_tu_name, this.new_tu_address);
}

class GetMetersFromTU extends ProfileEvent{
  String point_id;
  GetMetersFromTU(this.point_id);
}