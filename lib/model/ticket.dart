class Ticket{
  final String? ticket_id;
  final String? user_lk_id;
  final String? ticket_theme_id;
  final String? name;
  final String? is_closed;
  final String? contact_email;
  final _CurrentStatus? cur_status;
  final String? date_ticket;
  final String? last_tm_resiver;
  final String? count_tm_resiver;
  final String? date_ticket_added;
  final String? date_ticket_closed;
  final String? date_added;
  final String? date_closed;
  final String? href;

  Ticket(this.ticket_id, this.user_lk_id, this.ticket_theme_id, this.name,
      this.is_closed, this.contact_email, this.cur_status, this.date_ticket, this.last_tm_resiver, this.count_tm_resiver, this.date_ticket_added, this.date_ticket_closed, this.date_added, this.date_closed, this.href);
}

class _CurrentStatus{
  final String? ticket_status_type_id;
  final String? color_type_id;
  final String? user_lkrso_id;
  final String? date_added;
  final String? status;
  final String? hidden_type;
  final String? name;

  _CurrentStatus(this.ticket_status_type_id, this.color_type_id,
      this.user_lkrso_id, this.date_added, this.status, this.hidden_type, this.name);
}