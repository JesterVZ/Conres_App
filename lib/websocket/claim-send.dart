import 'dart:convert';

class ClaimSend {
  String? cmd;
  String? subject;
  String? event;
  Data? data;
  int? to_id;

  ClaimSend(
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
  int? claim_id;
  List<ClaimInfo>? claim_info;
  UserInfo? user_info;
  String? date_group;
  String? date_group_name;
  Data(
      {required this.user_type,
      required this.user_id,
      required this.files,
      required this.claim_id,
      required this.claim_info,
      required this.user_info,
      required this.date_group,
      required this.date_group_name});
  Map<String, dynamic> toJson() => {
        'user_type': user_type,
        'user_id': user_id,
        'files': files,
        'claim_id': claim_id,
        'claim_info': claim_info, //Сделать массив Map
        'user_info': user_info != null ? user_info!.toJson() : null,
        'date_group': date_group,
        'date_group_name': date_group_name
      };
}

class ClaimInfo {
  String? claim_message_id;
  String? claim_id;
  String? message;
  dynamic data;
  String? claims_status_id;
  String? model_user;
  String? user_id;
  String? user_name;
  String? date_added;
  String? text;
  String? last_claim_lk;
  dynamic files;

  ClaimInfo(
      {required this.claim_message_id,
      required this.claim_id,
      required this.message,
      required this.data,
      required this.claims_status_id,
      required this.model_user,
      required this.user_id,
      required this.user_name,
      required this.date_added,
      required this.text,
      required this.last_claim_lk,
      required this.files});

  Map<String, dynamic> toJson() => {
        'claim_message_id': claim_message_id,
        'claim_id': claim_id,
        'message': message,
        'data': data,
        'claims_status_id': claims_status_id,
        'model_user': model_user,
        'user_id': user_id,
        'user_name': user_name,
        'date_added': date_added,
        'text': text,
        'last_claim_lk': last_claim_lk,
        'files': files
      };
  factory ClaimInfo.fromMap(Map<String, dynamic> map){
    return ClaimInfo(
      claim_message_id: map['claim_message_id'], 
      claim_id: map['claim_id'], 
      message: map['message'], 
      data: map['data'], 
      claims_status_id: map['claims_status_id'], 
      model_user: map['model_user'], 
      user_id: map['user_id'], 
      user_name: map['user_name'], 
      date_added: map['date_added'], 
      text: map['text'], 
      last_claim_lk: map['last_claim_lk'], 
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

class Contacts {
  String? phone;
  String? email;
  Contacts({required this.phone, required this.email});
  Map<String, dynamic> toJson() => {'2': phone, '3': email};
}