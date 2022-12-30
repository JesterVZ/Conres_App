//модель
class MessageRead {
  String? cmd;
  String? subject;
  String? event;
  dynamic data;
  int? to_id;

  MessageRead(
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

class MessageReadData{
  String? message_id;
  int? ticket_id;
  int? user_id;
  String? user_type;
  MessageReadData({
    required this.message_id,
    required this.ticket_id,
    required this.user_id,
    required this.user_type
  });
    Map<String, dynamic> toJson() => {
        'message_id': message_id,
        'user_type': user_type,
        'user_id': user_id,
        'ticket_id': ticket_id,
      };
}

class ClaimMessageReadData{
  String? message_id;
  int? claim_id;
  int? user_id;
  String? user_type;
  ClaimMessageReadData({
    required this.message_id,
    required this.claim_id,
    required this.user_id,
    required this.user_type
  });
    Map<String, dynamic> toJson() => {
        'message_id': message_id,
        'user_type': user_type,
        'user_id': user_id,
        'claim_id': claim_id,
      };
}