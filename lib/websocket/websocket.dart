/* 
websocket.dart
Данные для сокета

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class WebSocketData{
  String? cmd;
  String? event;
  dynamic? data;
  WebSocketData({this.cmd, this.event, this.data});

  factory WebSocketData.fromMap(Map<String, dynamic> map){
    return WebSocketData(
      cmd: map['cmd'],
      event: map['event'],
      //data: map['data'] != null ? _Data.fromMap(map['data']) : null
      data: map['data']
    );
  }
}

class WebSocketServerData{
  int? status;
  bool? block_user;
  bool? block_balance;
  bool? block_diskspace;
  _Counters? counters;
  List<dynamic>? alerts;

  WebSocketServerData({this.status, this.block_user, this.block_balance, this.block_diskspace,
      this.counters, this.alerts});
  factory WebSocketServerData.fromMap(Map<String, dynamic> map){
    return WebSocketServerData(
      status: map['status'],
      block_balance: map['block_balance'],
      block_diskspace: map['block_diskspace'],
      block_user: map['block_user'],
      counters: map['counters'] != null ? _Counters.fromMap(map['counters']) : null
    );
  }
}

class _Counters{
  int? new_ticket_messages_count;
  int? new_claims_messages_count;
  _Counters({this.new_claims_messages_count, this.new_ticket_messages_count});

  factory _Counters.fromMap(Map<String, dynamic> map){
    return _Counters(
      new_claims_messages_count: map['new_claims_messages_count'],
      new_ticket_messages_count: map['new_ticket_messages_count']
    );
  }
}