import 'package:conres_app/model/login_service.dart';

class UserInformation{
  String? store_id;
  String? user_lk_id;
  String? send_link;
  String? url_location;
  String? action;
  String? legal_address;
  String? inn;
  String? firstname;
  String? lastname;
  String? patronymic;
  String? proxy_firstname;
  String? proxy_lastname;
  String? proxy_patronymic;
  String? proxy_telephone;
  String? proxy_email;
  String? company_full;
  String? company_short;
  String? kpp;
  String? ogrn;
  String? snils;
  String? user_lk_group_id;
  List<Contact>? user_info_contacts;
  //List<LoginService>? login_service;

  UserInformation({
    this.store_id,
    this.user_lk_id,
    this.send_link,
    this.url_location,
    this.action,
    this.legal_address,
    this.inn,
    this.firstname,
    this.lastname,
    this.patronymic,
    this.proxy_firstname,
    this.proxy_lastname,
    this.proxy_patronymic,
    this.proxy_email,
    this.proxy_telephone,
    this.company_full,
    this.company_short,
    this.kpp,
    this.snils,
    this.user_info_contacts,
    //this.login_service,
    this.ogrn,
    this.user_lk_group_id
  });

  factory UserInformation.fromMap(Map<dynamic, dynamic> map){
    return UserInformation(
      store_id: map['store_id'],
      user_lk_id: map['user_lk_id'],
      send_link: map['send_link'],
      url_location: map['url_location'],
      action: map['action'],
      legal_address: map['legal_address'] ?? "",
      inn: map['inn'] ?? "",
      firstname: map['firstname'] ?? "",
      lastname: map['lastname'] ?? "",
      patronymic: map['patronymic'] ?? "",
      proxy_firstname: map['proxy_firstname'] ?? "",
      proxy_lastname: map['proxy_lastname'] ?? "",
      proxy_patronymic: map['proxy_patronymic'] ?? "",
      proxy_email: map['proxy_email'] ?? "",
      proxy_telephone: map['proxy_telephone'] ?? "",
      company_full: map['company_full'] ?? "",
      company_short: map['company_short'] ?? "",
      kpp: map['kpp'] ?? "",
      snils: map['snils'] ?? "",
      //login_service: map['login_service'],
      ogrn: map['ogrn'] ?? "",
      user_lk_group_id: map['user_lk_group_id']
    );
  }
}

class Contact{
  String? value_contact;
  String? contact_type_group_id;

  Contact({this.value_contact, this.contact_type_group_id});

  factory Contact.fromMap(Map<dynamic, dynamic> map){
    return Contact(
      value_contact: map['value_contact'],
      contact_type_group_id: map['contact_type_group_id']
    );
  }
}