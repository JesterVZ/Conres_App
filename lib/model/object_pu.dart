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
      {this.object_id,
      this.name,
      this.address,
      this.account_id,
      this.date_added,
      this.hidden,
      this.status,
      this.comments});

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
