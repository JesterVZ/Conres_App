import 'dart:convert';

class TicketFullInfo{
  List<TicketMessage>? messages;
  int? messages_more;
  String? messages_page;
  String? last_message_id;
  String? last_read_msg;
  String? ticket_is_closed;

  TicketFullInfo({this.messages, this.messages_more, this.messages_page, this.last_message_id, this.last_read_msg, this.ticket_is_closed});
}
class TicketMessage{
  String? ticket_message_id;
  String? ticket_id;
  String? message;
  TicketFile? data;
  String? ticket_status_type_id;
  String? model_user;
  String? user_id;
  String? user_name;
  DateTime? date;
  String? name;
  String? color_type_id;
  String? last_tm_resiver;
  String? message_id;
  String? date_group;
  bool? isOwn; 

  TicketMessage({
    required this.ticket_message_id,
    required this.ticket_id,
    required this.message,
    this.data,
    required this.ticket_status_type_id,
    required this.model_user,
    required this.user_id,
    required this.user_name,
    required this.date,
    required this.name,
    required this.color_type_id,
    required this.last_tm_resiver,
    required this.message_id,
    required this.date_group,
    this.isOwn});
  factory TicketMessage.fromMap(Map<dynamic, dynamic> map){
    return TicketMessage(
        ticket_message_id: map['ticket_message_id'],
        ticket_id: map['ticket_id'],
        message: map['message'],
        data: map['files'] != null ? TicketFile.fromMap(map['files'][0]) : null,
        ticket_status_type_id: map['ticket_status_type_id'],
        model_user: map['model_user'],
        user_id: map['user_id'],
        user_name: map['user_name'],
        date: DateTime.parse(map['date_added']),
        name: map['name'],
        color_type_id: map['color_type_id'],
        last_tm_resiver: map['last_tm_resiver'],
        message_id: map['message_id'],
        date_group: map['date_group']);
  }
}
class TicketFile{
  String? document_name;
  String? filename;
  String? thumb;
  String? mime;
  String? file_href;
  String? file_href_mail;

  TicketFile({
    required this.document_name,
    required this.filename,
    required this.file_href,
    required this.file_href_mail,
    required this.thumb,
    required this.mime
  });

  factory TicketFile.fromJson(String source) => TicketFile.fromMap(json.decode(source));

  factory TicketFile.fromMap(Map<dynamic, dynamic> map){
    return TicketFile(
      document_name: map['document_name'],
      filename: map['filename'],
      file_href: map['file_href'],
      thumb: map['thumb'],
      file_href_mail: map['file_href_mail'],
      mime: map['mime']
    );
  }
}