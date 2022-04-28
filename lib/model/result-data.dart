import 'dart:convert';

class ResultData {
  int? code_result;
  _Message? code_msg;
  dynamic data;

  ResultData(
      {this.code_result, this.code_msg, this.data});

  factory ResultData.fromJson(String source) => ResultData.fromMap(json.decode(source));

  factory ResultData.fromMap(Map<String, dynamic> map){
    return ResultData(
        code_result: map['code_result'],
        code_msg: map['code_msg'] != null ? _Message.fromMap(map['code_msg']) : null,
        data: map['data']);

  }
}

class _Message {
  String? msg;
  dynamic custom_fields;
  _Message({this.msg, this.custom_fields});

  factory _Message.fromMap(Map<String, dynamic> map){
    return _Message(
        msg: map['msg'],
        custom_fields: map['custom_fields']
    );
  }
}

