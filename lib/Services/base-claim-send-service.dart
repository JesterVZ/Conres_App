import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class BaseClaimSendService {
  String? claim_type_id;
  String? claim_template;
  String? claim_type;
  String? claim_name;
  String? field_header_whom_1;
  String? field_phone;
  String? field_pass_serial;
  String? field_pass_number;
  String? field_pass_giver;
  String? field_email;
  String? field_content_date;
  String? field_header_who;
  String? field_header_egrul;
  String? field_header_address_1;
  String? field_header_address_2;
  String? field_header_egrul_date;
  String? field_content_main;
  String? claim_operator_email;
  Map<int?, FilePickerResult?>? files;
  VoidCallback? delegateFunc;
}
