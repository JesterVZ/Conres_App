class PuEditNew {
  bool? editPush;
  bool? edit;
  bool? approve;
  String? dateRevise;
  MeterInfo? meterInfo;
  String? requestId;
  String? objectId;
  String? objectName;
  String? objectAddress;
  String? newObjectName;
  String? newObjectAddress;
  List<Points>? points;
  List<PointsCur>? pointsCur;
  PuInfo? puInfo;
  String? meterId;
  String? accountId;
  String? accountNumber;
  String? userLkId;
  String? dateAdded;

  PuEditNew(
      {this.editPush,
      this.edit,
      this.approve,
      this.dateRevise,
      this.meterInfo,
      this.requestId,
      this.objectId,
      this.objectName,
      this.objectAddress,
      this.newObjectName,
      this.newObjectAddress,
      this.points,
      this.pointsCur,
      this.puInfo,
      this.meterId,
      this.accountId,
      this.accountNumber,
      this.userLkId,
      this.dateAdded});

  PuEditNew.fromJson(Map<String, dynamic> json) {
    editPush = json['edit_push'];
    edit = json['edit'];
    approve = json['approve'];
    dateRevise = json['date_revise'];
    meterInfo = json['meter_info'] != null
        ? new MeterInfo.fromJson(json['meter_info'])
        : null;
    requestId = json['request_id'];
    objectId = json['object_id'];
    objectName = json['object_name'];
    objectAddress = json['object_address'];
    newObjectName = json['new_object_name'];
    newObjectAddress = json['new_object_address'];
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(new Points.fromJson(v));
      });
    }
    if (json['points_cur'] != null) {
      pointsCur = <PointsCur>[];
      json['points_cur'].forEach((v) {
        pointsCur!.add(new PointsCur.fromJson(v));
      });
    }
    puInfo =
        json['pu_info'] != null ? new PuInfo.fromJson(json['pu_info']) : null;
    meterId = json['meter_id'];
    accountId = json['account_id'];
    accountNumber = json['account_number'];
    userLkId = json['user_lk_id'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['edit_push'] = this.editPush;
    data['edit'] = this.edit;
    data['approve'] = this.approve;
    data['date_revise'] = this.dateRevise;
    if (this.meterInfo != null) {
      data['meter_info'] = this.meterInfo!.toJson();
    }
    data['request_id'] = this.requestId;
    data['object_id'] = this.objectId;
    data['object_name'] = this.objectName;
    data['object_address'] = this.objectAddress;
    data['new_object_name'] = this.newObjectName;
    data['new_object_address'] = this.newObjectAddress;
    if (this.points != null) {
      data['points'] = this.points!.map((v) => v.toJson()).toList();
    }
    if (this.pointsCur != null) {
      data['points_cur'] = this.pointsCur!.map((v) => v.toJson()).toList();
    }
    if (this.puInfo != null) {
      data['pu_info'] = this.puInfo!.toJson();
    }
    data['meter_id'] = this.meterId;
    data['account_id'] = this.accountId;
    data['account_number'] = this.accountNumber;
    data['user_lk_id'] = this.userLkId;
    data['date_added'] = this.dateAdded;
    return data;
  }
}

class MeterInfo {
  String? meterId;
  String? name;
  String? number;
  String? tariffName;
  String? typeName;
  String? dateRevise;
  String? measureMultipler;

  MeterInfo(
      {this.meterId,
      this.name,
      this.number,
      this.tariffName,
      this.typeName,
      this.dateRevise,
      this.measureMultipler});

  MeterInfo.fromJson(Map<String, dynamic> json) {
    meterId = json['meter_id'];
    name = json['name'];
    number = json['number'];
    tariffName = json['tariff_name'];
    typeName = json['type_name'];
    dateRevise = json['date_revise'];
    measureMultipler = json['measure_multipler'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meter_id'] = this.meterId;
    data['name'] = this.name;
    data['number'] = this.number;
    data['tariff_name'] = this.tariffName;
    data['type_name'] = this.typeName;
    data['date_revise'] = this.dateRevise;
    data['measure_multipler'] = this.measureMultipler;
    return data;
  }
}

class Points {
  String? pointId;
  String? name;
  String? number;
  String? address;
  String? newName;
  String? newNumber;
  String? newAddress;

  Points(
      {this.pointId,
      this.name,
      this.number,
      this.address,
      this.newName,
      this.newNumber,
      this.newAddress});

  Points.fromJson(Map<String, dynamic> json) {
    pointId = json['point_id'];
    name = json['name'];
    number = json['number'];
    address = json['address'];
    newName = json['new_name'];
    newNumber = json['new_number'];
    newAddress = json['new_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['point_id'] = this.pointId;
    data['name'] = this.name;
    data['number'] = this.number;
    data['address'] = this.address;
    data['new_name'] = this.newName;
    data['new_number'] = this.newNumber;
    data['new_address'] = this.newAddress;
    return data;
  }
}

class PointsCur {
  String? pointId;
  String? name;
  String? number;
  String? address;

  PointsCur({this.pointId, this.name, this.number, this.address});

  PointsCur.fromJson(Map<String, dynamic> json) {
    pointId = json['point_id'];
    name = json['name'];
    number = json['number'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['point_id'] = this.pointId;
    data['name'] = this.name;
    data['number'] = this.number;
    data['address'] = this.address;
    return data;
  }
}

class PuInfo {
  String? objectId;
  String? meterId;
  String? accountNumber;
  List<String>? newTuId;
  String? newTuNumber;
  String? newTuName;
  String? newPuAddress;
  String? newPuName;
  String? newPuNumber;
  String? newPuType;
  String? newPuZone;
  String? newPuRatio;
  String? tariffName;
  String? readingsQuantity;
  String? typeName;

  PuInfo(
      {this.objectId,
      this.meterId,
      this.accountNumber,
      this.newTuId,
      this.newTuNumber,
      this.newTuName,
      this.newPuAddress,
      this.newPuName,
      this.newPuNumber,
      this.newPuType,
      this.newPuZone,
      this.newPuRatio,
      this.tariffName,
      this.readingsQuantity,
      this.typeName});

  PuInfo.fromJson(Map<String, dynamic> json) {
    objectId = json['object_id'];
    meterId = json['meter_id'];
    accountNumber = json['account_number'];
    newTuId = json['new_tu_id'].cast<String>();
    newTuNumber = json['new_tu_number'];
    newTuName = json['new_tu_name'];
    newPuAddress = json['new_pu_address'];
    newPuName = json['new_pu_name'];
    newPuNumber = json['new_pu_number'];
    newPuType = json['new_pu_type'];
    newPuZone = json['new_pu_zone'];
    newPuRatio = json['new_pu_ratio'];
    tariffName = json['tariff_name'];
    readingsQuantity = json['readings_quantity'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_id'] = this.objectId;
    data['meter_id'] = this.meterId;
    data['account_number'] = this.accountNumber;
    data['new_tu_id'] = this.newTuId;
    data['new_tu_number'] = this.newTuNumber;
    data['new_tu_name'] = this.newTuName;
    data['new_pu_address'] = this.newPuAddress;
    data['new_pu_name'] = this.newPuName;
    data['new_pu_number'] = this.newPuNumber;
    data['new_pu_type'] = this.newPuType;
    data['new_pu_zone'] = this.newPuZone;
    data['new_pu_ratio'] = this.newPuRatio;
    data['tariff_name'] = this.tariffName;
    data['readings_quantity'] = this.readingsQuantity;
    data['type_name'] = this.typeName;
    return data;
  }
}