import 'dart:convert';

class MessageSend {
  String? cmd;
  String? subject;
  String? event;
  dynamic? data;
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

class MessageSendData {
  String? user_type;
  int? user_id;
  List<dynamic>? files;
  int? ticket_id;
  List<TicketInfo>? ticket_info;
  UserInfo? user_info;
  String? date_group;
  String? date_group_name;
  MessageSendData(
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
  factory TicketInfo.fromMap(Map<String, dynamic> map){
    return TicketInfo(
      ticket_message_id: map['ticket_message_id'], 
      ticket_id: map['ticket_id'], 
      message: map['message'], 
      data: map['data'], 
      ticket_status_type_id: map['ticket_status_type_id'], 
      model_user: map['model_user'], 
      user_id: map['user_id'], 
      user_name: map['user_name'], 
      date_added: map['date_added'], 
      name: map['name'], 
      color_type_id: map['color_type_id'], 
      last_tm_resiver: map['last_tm_resiver'], 
      files: map['files']);
  }
}

class UserInfo {
  String? inn;
  String? firstname;
  String? lastname;
  String? patronymic;
  Contacts? contacts;
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
        'contacts': contacts != null ? contacts!.toJson() : null,
        'href': href
      };
}

class AccountNew{
  int? account_id;
  String? account_bind_number;
  String? account_bind_address;
  String? inn;
  int? user_lk_id;
  String? date_add;
  String? type;

  AccountNew({
    required this.account_id,
    required this.account_bind_number,
    required this.account_bind_address,
    required this.inn,
    required this.user_lk_id,
    required this.date_add,
    required this.type
  });

  Map<String, dynamic> toJson() => {
        'account_id': account_id,
        'account_bind_number': account_bind_number,
        'account_bind_address': account_bind_address,
        'inn': inn,
        'user_lk_id': user_lk_id,
        'date_add': date_add,
        'type': type
      };
}

class AccountHidden{
  String? account_id;
  AccountHidden({
    required this.account_id
  });
  Map<String, dynamic> toJson() => {
    'account_id': account_id
  };
}

class TicketNew{
  String? ticket_theme_id;
  String? contact_name;
  String? contact_email;
  String? user_lk_id;
  int? ticket_id;
  int? count_tm_sender;
  int? responsible_id;
  String? date_added;
  String? status_id;
  String? color_type_id;
  String? name;
  String? name_theme;

  TicketNew({
    required this.ticket_theme_id,
    required this.contact_name,
    required this.contact_email,
    required this.user_lk_id,
    required this.color_type_id,
    required this.count_tm_sender,
    required this.date_added,
    required this.name,
    required this.name_theme,
    required this.responsible_id,
    required this.status_id,
    required this.ticket_id
  });
  Map<String, dynamic> toJson() => {
    'ticket_theme_id': ticket_theme_id,
    'contact_name': contact_name,
    'contact_email': contact_email,
    'user_lk_id': user_lk_id,
    'ticket_id': ticket_id,
    'count_tm_sender': count_tm_sender,
    'responsible_id': responsible_id,
    'date_added': date_added,
    'status_id': status_id,
    'color_type_id': color_type_id,
    'name': name,
    'name_theme': name_theme
  };
}

class Contacts {
  String? phone;
  String? email;
  Contacts({required this.phone, required this.email});
  Map<String, dynamic> toJson() => {'2': phone, '3': email};
}
