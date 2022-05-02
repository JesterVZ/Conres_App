import 'dart:convert';

class MessageSend {
  String? cmd;
  String? subject;
  String? event;
  Data? data;
  int? to_id;

  MessageSend(
      {required this.cmd,
      required this.subject,
      required this.event,
      required this.data,
      required this.to_id});
  Map<String, dynamic> toJson() => {
        'cmd': cmd,
        'subject': subject,
        'event': event,
        'data': data != null ? data!.toJson() : null,
        'to_id': to_id
      };
}

class Data {
  String? user_type;
  int? user_id;
  List<dynamic>? files;
  int? ticket_id;
  List<TicketInfo>? ticket_info;
  UserInfo? user_info;
  String? date_group;
  String? date_group_name;
  Data(
      {required this.user_type,
      required this.user_id,
      required this.files,
      required this.ticket_id,
      required this.ticket_info,
      required this.user_info,
      required this.date_group,
      required this.date_group_name});
  Map<String, dynamic> toJson() => {
        'user_type': user_type,
        'user_id': user_id,
        'files': files,
        'ticket_id': ticket_id,
        'ticket_info': ticket_info, //Сделать массив Map
        'user_info': user_info != null ? user_info!.toJson() : null,
        'date_group': date_group,
        'date_group_name': date_group_name
      };
}

class TicketInfo {
  String? ticket_message_id;
  String? ticket_id;
  String? message;
  dynamic data;
  String? ticket_status_type_id;
  String? model_user;
  String? user_id;
  String? user_name;
  String? date_added;
  String? name;
  String? color_type_id;
  String? last_tm_resiver;
  dynamic files;

  TicketInfo(
      {required this.ticket_message_id,
      required this.ticket_id,
      required this.message,
      required this.data,
      required this.ticket_status_type_id,
      required this.model_user,
      required this.user_id,
      required this.user_name,
      required this.date_added,
      required this.name,
      required this.color_type_id,
      required this.last_tm_resiver,
      required this.files});

  Map<String, dynamic> toJson() => {
        'ticket_message_id': ticket_message_id,
        'ticket_id': ticket_id,
        'message': message,
        'data': data,
        'ticket_status_type_id': ticket_status_type_id,
        'model_user': model_user,
        'user_id': user_id,
        'user_name': user_name,
        'date_added': date_added,
        'name': name,
        'color_type_id': color_type_id,
        'last_tm_resiver': last_tm_resiver,
        'files': files
      };
}

class UserInfo {
  String? inn;
  String? firstname;
  String? lastname;
  String? patronymic;
  dynamic? contacts;
  String? href;

  UserInfo(
      {required this.inn,
      required this.firstname,
      required this.lastname,
      required this.patronymic,
      required this.contacts,
      required this.href});
  Map<String, dynamic> toJson() => {
        'inn': inn,
        'firstname': firstname,
        'lastname': lastname,
        'patronymic': patronymic,
        'contacts': contacts,
        'href': href
      };
}
