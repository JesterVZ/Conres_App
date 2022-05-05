class TicketMessage{
  String? ticket_message_id;
  String? ticket_id;
  String? message;
  String? data;
  String? ticket_status_type_id;
  String? model_user;
  String? user_id;
  String? user_name;
  DateTime? date_added;
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
    required this.data,
    required this.ticket_status_type_id,
    required this.model_user,
    required this.user_id,
    required this.user_name,
    required this.date_added,
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
        data: map['data'],
        ticket_status_type_id: map['ticket_status_type_id'],
        model_user: map['model_user'],
        user_id: map['user_id'],
        user_name: map['user_name'],
        date_added: DateTime.parse(map['date_added']),
        name: map['name'],
        color_type_id: map['color_type_id'],
        last_tm_resiver: map['last_tm_resiver'],
        message_id: map['message_id'],
        date_group: map['date_group']);
  }
}