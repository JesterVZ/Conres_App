class TuModel{
  String? point_id;
  String? object_id;
  String? name;
  String? number;
  String? address;
  String? date_added;
  String? status;
  String? hidden;
  String? comments;

  TuModel({
    this.point_id,
    this.object_id,
    this.name,
    this.number,
    this.address,
    this.date_added,
    this.hidden,
    this.status,
    this.comments
  });

  factory TuModel.fromMap(Map<String, dynamic> map){
    return TuModel(
      point_id: map['point_id'],
      object_id: map['object_id'],
      name: map['name'],
      number: map['number'],
      address: map['address'],
      date_added: map['date_added'],
      status: map['status'],
      hidden: map['hidden'],
      comments: map['comments']
    );
  }
}