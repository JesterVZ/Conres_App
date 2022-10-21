class TuModel{
  String? point_id;
  String? object_id;
  String? name;
  String? number;
  String? address;
  String? date_added;
  String? status;
  String? hidden;

  TuModel({
    required this.point_id,
    required this.object_id,
    required this.name,
    required this.number,
    required this.address,
    required this.date_added,
    required this.hidden,
    required this.status
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
      hidden: map['hidden']
    );
  }
}