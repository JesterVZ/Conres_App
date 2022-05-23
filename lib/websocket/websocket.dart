class WebSocketData{
  String? cmd;
  String? event;
  _Data? data;
  WebSocketData({this.cmd, this.event, this.data});

  factory WebSocketData.fromMap(Map<String, dynamic> map){
    return WebSocketData(
      cmd: map['cmd'],
      event: map['event'],
      data: map['data'] != null ? _Data.fromMap(map['data']) : null
    );
  }
}

class _Data{
  int? status;
  bool? block_user;
  bool? block_balance;
  bool? block_diskspace;
  _Counters? counters;
  List<dynamic>? alerts;

  _Data({this.status, this.block_user, this.block_balance, this.block_diskspace,
      this.counters, this.alerts});
  factory _Data.fromMap(Map<String, dynamic> map){
    return _Data(
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