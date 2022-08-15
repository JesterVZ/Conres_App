class Ticket{
  final String? ticket_id;
  final String? user_lk_id;
  final String? ticket_theme_id;
  String? name;
  final String? is_closed;
  final String? contact_email;
  _CurrentStatus? cur_status;
  final String? date_ticket;
  final String? last_tm_resiver;
  String? count_tm_resiver;
  final String? date_ticket_added;
  final String? date_ticket_closed;
  final String? date_added;
  final String? date_closed;
  final String? href;

  Ticket(
  {this.ticket_id,
  this.user_lk_id,
  this.ticket_theme_id,
  this.name,
  this.is_closed,
  this.contact_email,
  this.cur_status,
  this.date_ticket,
  this.last_tm_resiver,
  this.count_tm_resiver,
  this.date_ticket_added,
  this.date_ticket_closed,
  this.date_added,
  this.date_closed,
  this.href});
  factory Ticket.fromMap(Map<dynamic, dynamic> map){
    return Ticket(
      ticket_id: map['ticket_id'],
      user_lk_id: map['user_lk_id'],
      ticket_theme_id: map['ticket_theme_id'],
      name: map['name'],
      is_closed: map['is_closed'],
      contact_email: map['contact_email'],
      cur_status: map['cur_status'] != null ? _CurrentStatus.fromMap(map['cur_status']) : null,
      date_ticket: map['date_ticket'],
      last_tm_resiver: map['last_tm_resiver'],
      count_tm_resiver: map['count_tm_resiver'],
      date_ticket_added: map['date_ticket_added'],
      date_ticket_closed: map['date_ticket_closed'],
      date_added: map['date_added'],
      date_closed: map['date_closed'],
      href: map['href']
    );
  }
}

class _CurrentStatus{
  final String? ticket_status_type_id;
  final String? color_type_id;
  final String? user_lkrso_id;
  final String? date_added;
  final String? status;
  final String? hidden_type;
  String? name;

  _CurrentStatus({
    this.ticket_status_type_id,
    this.color_type_id,
    this.user_lkrso_id,
    this.date_added,
    this.status,
    this.hidden_type,
    this.name});
  factory _CurrentStatus.fromMap(Map<dynamic, dynamic> map){
    return _CurrentStatus(
      ticket_status_type_id: map['ticket_status_type_id'],
      color_type_id: map['color_type_id'],
      user_lkrso_id: map['user_lkrso_id'],
      date_added: map['date_added'],
      status: map['status'],
      hidden_type: map['hidden_type'],
      name: map['name']
    );
  }
}