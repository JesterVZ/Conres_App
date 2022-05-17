class Counter{
  String? ticket_id;
  String? count_tm_resiver;
  Counter({required this.ticket_id, required this.count_tm_resiver});
  factory Counter.fromMap(Map<dynamic, dynamic> map){
    return Counter(
      ticket_id: map['ticket_id'], 
      count_tm_resiver: map['count_tm_resiver']);
  }
}