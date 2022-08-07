class Contract {
  String? account_id;
  String? account_number;
  String? account_address;
  String? status;
  String? comments;
  String? approve;
  bool? isCurrent;
  String? date_added;
  Contract(
      {required this.account_id,
      required this.account_number,
      required this.account_address,
      required this.status,
      required this.comments,
      required this.approve,
      required this.date_added,
      this.isCurrent});
  factory Contract.fromMap(Map<dynamic, dynamic> map){
    return Contract(
      account_id: map['account_id'],
      account_number: map['account_number'],
      account_address: map['account_address'],
      status: map['status'],
      comments: map['comments'],
      approve: map['approve'],
      date_added: map['date_added']
    );
  }
}
