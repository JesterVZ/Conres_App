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

class ClaimNew{
  int? claim_id;
  String? claim_shortname;
  String? claim_name;
  String? date_time;
  String? date;
  String? user_lk_id;
  String? user_inn;
  String? user_account_number;
  String? claim_href;

  ClaimNew({
    required this.claim_id,
    required this.claim_shortname,
    required this.claim_name,
    required this.date_time,
    required this.date,
    required this.user_lk_id,
    required this.user_inn,
    required this.user_account_number,
    required this.claim_href
  });

  Map<String, dynamic> toJson() => {
    'claim_id': claim_id,
    'claim_shortname': claim_shortname,
    'claim_name': claim_name,
    'date_time': date_time,
    'date': date,
    'user_lk_id': user_lk_id,
    'user_inn': user_inn,
    'user_account_number': user_account_number,
    'claim_href': claim_href
  };
}

class Contacts {
  String? phone;
  String? email;
  Contacts({required this.phone, required this.email});
  Map<String, dynamic> toJson() => {'2': phone, '3': email};
}

class ObjectNew{
  int? object_id;
  String? user_lk_id;
  String? account_id;
  String? account_number;
  String? date_added;
  String? object_name;
  String? object_address;

  ObjectNew({
    required this.object_id,
    required this.user_lk_id,
    required this.account_id,
    required this.account_number,
    required this.date_added,
    required this.object_name,
    required this.object_address
  });

  Map<String, dynamic> toJson() => {
        'object_id': object_id,
        'user_lk_id': user_lk_id,
        'account_id': account_id,
        'account_number': account_number,
        'date_added': date_added,
        'object_name': object_name,
        'object_address': object_address
      };
}

class ObjectHidden{
  int? object_id;
  ObjectHidden({required this.object_id});
  Map<String, dynamic> toJson() => {
    'object_id': object_id
  };
}

class ObjectEdited {
  String? objectId;
  String? newObjectName;
  String? newObjectAddress;
  String? accountId;
  String? accountNumber;
  String? userLkId;
  String? dateAdded;
  bool? edit;
  bool? approve;
  int? requestId;
  String? objectAddress;
  String? objectName;

  ObjectEdited(
      {this.objectId,
      this.newObjectName,
      this.newObjectAddress,
      this.accountId,
      this.accountNumber,
      this.userLkId,
      this.dateAdded,
      this.edit,
      this.approve,
      this.requestId,
      this.objectAddress,
      this.objectName});

  ObjectEdited.fromJson(Map<String, dynamic> json) {
    objectId = json['object_id'];
    newObjectName = json['new_object_name'];
    newObjectAddress = json['new_object_address'];
    accountId = json['account_id'];
    accountNumber = json['account_number'];
    userLkId = json['user_lk_id'];
    dateAdded = json['date_added'];
    edit = json['edit'];
    approve = json['approve'];
    requestId = json['request_id'];
    objectAddress = json['object_address'];
    objectName = json['object_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_id'] = this.objectId;
    data['new_object_name'] = this.newObjectName;
    data['new_object_address'] = this.newObjectAddress;
    data['account_id'] = this.accountId;
    data['account_number'] = this.accountNumber;
    data['user_lk_id'] = this.userLkId;
    data['date_added'] = this.dateAdded;
    data['edit'] = this.edit;
    data['approve'] = this.approve;
    data['request_id'] = this.requestId;
    data['object_address'] = this.objectAddress;
    data['object_name'] = this.objectName;
    return data;
  }
}

class TuNew {
  String? objectId;
  String? newObjectName;
  String? newObjectAddress;
  String? code;
  String? msg;
  int? pointId;
  String? accountId;
  String? accountNumber;
  String? userLkId;
  String? dateAdded;
  String? newPointName;
  String? newPointNumber;
  String? newPointAddress;
  String? html;

  TuNew(
      {this.objectId,
      this.newObjectName,
      this.newObjectAddress,
      this.code,
      this.msg,
      this.pointId,
      this.accountId,
      this.accountNumber,
      this.userLkId,
      this.html,
      this.dateAdded,
      this.newPointName,
      this.newPointNumber,
      this.newPointAddress});

  TuNew.fromJson(Map<String, dynamic> json) {
    objectId = json['object_id'];
    newObjectName = json['new_object_name'];
    newObjectAddress = json['new_object_address'];
    code = json['code'];
    msg = json['msg'];
    pointId = json['point_id'];
    accountId = json['account_id'];
    accountNumber = json['account_number'];
    userLkId = json['user_lk_id'];
    dateAdded = json['date_added'];
    newPointName = json['new_point_name'];
    newPointNumber = json['new_point_number'];
    newPointAddress = json['new_point_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_id'] = this.objectId;
    data['new_object_name'] = this.newObjectName;
    data['new_object_address'] = this.newObjectAddress;
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['point_id'] = this.pointId;
    data['account_id'] = this.accountId;
    data['account_number'] = this.accountNumber;
    data['user_lk_id'] = this.userLkId;
    data['date_added'] = this.dateAdded;
    data['new_point_name'] = this.newPointName;
    data['new_point_number'] = this.newPointNumber;
    data['new_point_address'] = this.newPointAddress;
    data['html'] = this.html;
    return data;
  }
}

class TuHidden{
  int? point_id;
  TuHidden({required this.point_id});
  Map<String, dynamic> toJson() => {
    'point_id': point_id
  };
}

class MeterHidden{
  int? meter_id;
  MeterHidden({required this.meter_id});
  Map<String, dynamic> toJson() => {
    'meter_id': meter_id
  };
}

class TuEdited {
  bool? edit;
  bool? editPush;
  bool? approve;
  int? requestId;
  String? pointId;
  String? newPointName;
  String? newPointNumber;
  String? newPointAddress;
  String? pointName;
  String? pointNumber;
  String? pointAddress;
  String? objectName;
  String? objectAddress;
  String? newObjectName;
  String? newObjectAddress;
  String? accountId;
  String? accountNumber;
  String? userLkId;
  String? dateAdded;

  TuEdited(
      {this.edit,
      this.editPush,
      this.approve,
      this.requestId,
      this.pointId,
      this.newPointName,
      this.newPointNumber,
      this.newPointAddress,
      this.pointName,
      this.pointNumber,
      this.pointAddress,
      this.objectName,
      this.objectAddress,
      this.newObjectName,
      this.newObjectAddress,
      this.accountId,
      this.accountNumber,
      this.userLkId,
      this.dateAdded});

  TuEdited.fromJson(Map<String, dynamic> json) {
    edit = json['edit'];
    editPush = json['edit_push'];
    approve = json['approve'];
    requestId = json['request_id'];
    pointId = json['point_id'];
    newPointName = json['new_point_name'];
    newPointNumber = json['new_point_number'];
    newPointAddress = json['new_point_address'];
    pointName = json['point_name'];
    pointNumber = json['point_number'];
    pointAddress = json['point_address'];
    objectName = json['object_name'];
    objectAddress = json['object_address'];
    newObjectName = json['new_object_name'];
    newObjectAddress = json['new_object_address'];
    accountId = json['account_id'];
    accountNumber = json['account_number'];
    userLkId = json['user_lk_id'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['edit'] = this.edit;
    data['edit_push'] = this.editPush;
    data['approve'] = this.approve;
    data['request_id'] = this.requestId;
    data['point_id'] = this.pointId;
    data['new_point_name'] = this.newPointName;
    data['new_point_number'] = this.newPointNumber;
    data['new_point_address'] = this.newPointAddress;
    data['point_name'] = this.pointName;
    data['point_number'] = this.pointNumber;
    data['point_address'] = this.pointAddress;
    data['object_name'] = this.objectName;
    data['object_address'] = this.objectAddress;
    data['new_object_name'] = this.newObjectName;
    data['new_object_address'] = this.newObjectAddress;
    data['account_id'] = this.accountId;
    data['account_number'] = this.accountNumber;
    data['user_lk_id'] = this.userLkId;
    data['date_added'] = this.dateAdded;
    return data;
  }
}

class UserInfoEdit {
  List<UserEditInfo>? userEditInfo;
  String? userLkId;
  String? userFio;

  UserInfoEdit({this.userEditInfo, this.userLkId, this.userFio});

  UserInfoEdit.fromJson(Map<String, dynamic> json) {
    if (json['user_edit_info'] != null) {
      userEditInfo = <UserEditInfo>[];
      json['user_edit_info'].forEach((v) {
        userEditInfo!.add(new UserEditInfo.fromJson(v));
      });
    }
    userLkId = json['user_lk_id'];
    userFio = json['user_fio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userEditInfo != null) {
      data['user_edit_info'] =
          this.userEditInfo!.map((v) => v.toJson()).toList();
    }
    data['user_lk_id'] = this.userLkId;
    data['user_fio'] = this.userFio;
    return data;
  }
}

class UserEditInfo {
  String? uidField;
  String? value;
  int? requestId;
  String? dateAdded;
  String? valueCurrent;
  String? uidFieldName;

  UserEditInfo(
      {this.uidField,
      this.value,
      this.requestId,
      this.dateAdded,
      this.valueCurrent,
      this.uidFieldName});

  UserEditInfo.fromJson(Map<String, dynamic> json) {
    uidField = json['uid_field'];
    value = json['value'];
    requestId = json['request_id'];
    dateAdded = json['date_added'];
    valueCurrent = json['value_current'];
    uidFieldName = json['uid_field_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid_field'] = this.uidField;
    data['value'] = this.value;
    data['request_id'] = this.requestId;
    data['date_added'] = this.dateAdded;
    data['value_current'] = this.valueCurrent;
    data['uid_field_name'] = this.uidFieldName;
    return data;
  }
}