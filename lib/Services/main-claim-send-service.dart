import 'dart:ui';

import 'package:file_picker/file_picker.dart';

import '../elements/claims/claim-step2-object.dart';
import '../model/claims/claim-step-2-object.dart';

class MainClaimSendService {
  String? claim_type_id;
  String? claim_template;
  String? claim_type;
  String? claim_name;
  String? field_header_whom_1;

  String? field_header_who;
  String? field_header_egrul;
  String? field_header_address_1;
  String? field_header_address_2;
  String? field_phone;
  String? field_header_egrul_date;
  String? reason;
  String? field_pass_serial;
  String? field_pass_number;
  String? field_pass_giver;
  List<ClaimStep2TableObject?>? step2Object;
  String? field_max_power_3;
  String? field_max_voltage_3;
  String? field_max_connect_power_3;
  String? field_max_connect_voltage_3;
  String? field_max_current_power_3;
  String? field_max_current_voltage_3;
  String? field_max_power_2;
  String? field_max_voltage_2;
  String? field_max_connect_power_2;
  String? field_max_connect_voltage_2;
  String? field_max_current_power_2;
  String? field_max_current_voltage_2;
  String? field_max_power_1;
  String? field_max_voltage_1;
  String? field_max_connect_power_1;
  String? field_max_connect_voltage_1;
  String? field_max_current_power_1;
  String? field_max_current_voltage_1;
  String? field_load_nature;
  String? field_tech_min;
  String? field_emergency_armor_needed;
  String? field_emergency_armor_count;
  String? field_count_power_transformer;
  String? field_count_power_generator;
  String? field_gp;
  String? field_contract_type;
  Map<int?, FilePickerResult?>? files;
  VoidCallback? delegateFunc;
}
