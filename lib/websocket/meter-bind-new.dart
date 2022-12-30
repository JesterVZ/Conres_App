/* 
meter-bind-new.dart
Модель для привязки объекта ПУ

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class BindTuNew {
  String? newObjectName;
  String? newObjectAddress;
  String? objectId;
  List<PointsMeter>? points;
  int? meterId;
  String? code;
  String? msg;
  String? dateRevise;
  String? accountId;
  String? accountNumber;
  String? userLkId;
  String? dateAdded;
  PuInfo? puInfo;

  BindTuNew(
      {this.newObjectName,
      this.newObjectAddress,
      this.objectId,
      this.points,
      this.meterId,
      this.code,
      this.msg,
      this.dateRevise,
      this.accountId,
      this.accountNumber,
      this.userLkId,
      this.dateAdded,
      this.puInfo});

  BindTuNew.fromJson(Map<String, dynamic> json) {
    newObjectName = json['new_object_name'];
    newObjectAddress = json['new_object_address'];
    objectId = json['object_id'];
    if (json['points'] != null) {
      points = <PointsMeter>[];
      json['points'].forEach((v) {
        points!.add(new PointsMeter.fromJson(v));
      });
    }
    meterId = json['meter_id'];
    code = json['code'];
    msg = json['msg'];
    dateRevise = json['date_revise'];
    accountId = json['account_id'];
    accountNumber = json['account_number'];
    userLkId = json['user_lk_id'];
    dateAdded = json['date_added'];
    puInfo =
        json['pu_info'] != null ? new PuInfo.fromJson(json['pu_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_object_name'] = this.newObjectName;
    data['new_object_address'] = this.newObjectAddress;
    data['object_id'] = this.objectId;
    if (this.points != null) {
      data['points'] = this.points!.map((v) => v.toJson()).toList();
    }
    data['meter_id'] = this.meterId;
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['date_revise'] = this.dateRevise;
    data['account_id'] = this.accountId;
    data['account_number'] = this.accountNumber;
    data['user_lk_id'] = this.userLkId;
    data['date_added'] = this.dateAdded;
    if (this.puInfo != null) {
      data['pu_info'] = this.puInfo!.toJson();
    }
    return data;
  }
}

class PointsMeter {
  String? pointId;
  String? newName;
  String? newNumber;
  String? newAddress;

  PointsMeter({this.pointId, this.newName, this.newNumber, this.newAddress});

  PointsMeter.fromJson(Map<String, dynamic> json) {
    pointId = json['point_id'];
    newName = json['new_name'];
    newNumber = json['new_number'];
    newAddress = json['new_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['point_id'] = this.pointId;
    data['new_name'] = this.newName;
    data['new_number'] = this.newNumber;
    data['new_address'] = this.newAddress;
    return data;
  }
}

class PuInfo {
  String? newObjectId;
  String? newObjectName;
  String? newObjectAddress;
  List<String>? newTuId;
  String? newTuNumber;
  String? newTuName;
  String? newPuAddress;
  String? newPuName;
  String? newPuNumber;
  String? newPuType;
  String? newPuZone;
  String? newPuRatio;
  String? userLkId;
  String? newDateRevise;
  String? tariffName;
  String? typeName;

  PuInfo(
      {this.newObjectId,
      this.newObjectName,
      this.newObjectAddress,
      this.newTuId,
      this.newTuNumber,
      this.newTuName,
      this.newPuAddress,
      this.newPuName,
      this.newPuNumber,
      this.newPuType,
      this.newPuZone,
      this.newPuRatio,
      this.userLkId,
      this.newDateRevise,
      this.tariffName,
      this.typeName});

  PuInfo.fromJson(Map<String, dynamic> json) {
    newObjectId = json['new_object_id'];
    newObjectName = json['new_object_name'];
    newObjectAddress = json['new_object_address'];
    newTuId = json['new_tu_id'].cast<String>();
    newTuNumber = json['new_tu_number'];
    newTuName = json['new_tu_name'];
    newPuAddress = json['new_pu_address'];
    newPuName = json['new_pu_name'];
    newPuNumber = json['new_pu_number'];
    newPuType = json['new_pu_type'];
    newPuZone = json['new_pu_zone'];
    newPuRatio = json['new_pu_ratio'];
    userLkId = json['user_lk_id'];
    newDateRevise = json['new_date_revise'];
    tariffName = json['tariff_name'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_object_id'] = this.newObjectId;
    data['new_object_name'] = this.newObjectName;
    data['new_object_address'] = this.newObjectAddress;
    data['new_tu_id'] = this.newTuId;
    data['new_tu_number'] = this.newTuNumber;
    data['new_tu_name'] = this.newTuName;
    data['new_pu_address'] = this.newPuAddress;
    data['new_pu_name'] = this.newPuName;
    data['new_pu_number'] = this.newPuNumber;
    data['new_pu_type'] = this.newPuType;
    data['new_pu_zone'] = this.newPuZone;
    data['new_pu_ratio'] = this.newPuRatio;
    data['user_lk_id'] = this.userLkId;
    data['new_date_revise'] = this.newDateRevise;
    data['tariff_name'] = this.tariffName;
    data['type_name'] = this.typeName;
    return data;
  }
}
