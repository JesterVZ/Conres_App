class ObjectPuModel {
  String? object_id;
  String? name;
  String? address;
  String? account_id;
  String? date_added;
  String? status;
  String? hidden;
  String? comments;

  ObjectPuModel(
      {required this.object_id,
      required this.name,
      required this.address,
      required this.account_id,
      required this.date_added,
      required this.hidden,
      required this.status,
      required this.comments});

  factory ObjectPuModel.fromMap(Map<String, dynamic> map) {
    return ObjectPuModel(
        object_id: map['object_id'],
        name: map['name'],
        address: map['address'],
        account_id: map['account_id'],
        date_added: map['date_added'],
        hidden: map['hidden'],
        status: map['status'],
        comments: map['comments']);
  }
}
