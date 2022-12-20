class EditRequestModel {
  String? requestId;
  String? userLkId;
  String? uidField;
  String? value;
  String? dateAdded;
  Null? dateClosed;
  String? status;
  String? comments;
  String? userLkrsoId;

  EditRequestModel(
      {this.requestId,
      this.userLkId,
      this.uidField,
      this.value,
      this.dateAdded,
      this.dateClosed,
      this.status,
      this.comments,
      this.userLkrsoId});

  EditRequestModel.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    userLkId = json['user_lk_id'];
    uidField = json['uid_field'];
    value = json['value'];
    dateAdded = json['date_added'];
    dateClosed = json['date_closed'];
    status = json['status'];
    comments = json['comments'];
    userLkrsoId = json['user_lkrso_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['user_lk_id'] = this.userLkId;
    data['uid_field'] = this.uidField;
    data['value'] = this.value;
    data['date_added'] = this.dateAdded;
    data['date_closed'] = this.dateClosed;
    data['status'] = this.status;
    data['comments'] = this.comments;
    data['user_lkrso_id'] = this.userLkrsoId;
    return data;
  }
}