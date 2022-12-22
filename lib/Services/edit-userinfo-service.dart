/* 
edit-userinfo-service.dart
Сервис для редактирования информации о пользователе

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class EdutUserinfoService {
  String? tab;

  String? user_lk_id;
  String? user_lk_type_id; //Физик - 1 ИП - 2 ЮЛ - 3
  String? lastname;
  String? firstname;
  String? patronymic;
  String? company_full;
  String? company_short;
  String? inn;
  String? ogrn;
  String? kpp;
  String? legal_address;
  String? fact_address;
  String? snins;
  String? password;
  String? confirm;

  List? phones = [];
  List? emails = [];
  List? messangers = [];

  String? proxy_lastname;
  String? proxy_firstname;
  String? proxy_patronymic;
  String? proxy_telephone;
  String? proxy_email;
}
