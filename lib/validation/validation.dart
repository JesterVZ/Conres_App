/* 
validation.dart
Регулярки

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */

bool isEmailValidate(String val) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(val);
}

bool isPhoneValidate(String val) {
  return RegExp(r'[0-9\-\+]{9,15}$').hasMatch(val);
}

bool isSnilsValidate(String val) {
  return RegExp(r'^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$')
      .hasMatch(val);
}

bool isInnValidate(String val) {
  return RegExp(r'[0-9]{12}$').hasMatch(val);
}

bool isInnIpValidate(String val) {
  return RegExp(r'[0-9]{10}$').hasMatch(val);
}

bool isOgrnipValidate(String val) {
  return RegExp(r'[0-9]{15}$').hasMatch(val);
}

bool isOgrnValidate(String val) {
  return RegExp(r'[0-9]{13}$').hasMatch(val);
}

bool isOgrnipUlValidate(String val) {
  return RegExp(r'[0-9]{13}$').hasMatch(val);
}

bool isKppValidate(String val) {
  return RegExp(r'[0-9]{9}$').hasMatch(val);
}

bool isLsvalidate(String val) {
  return RegExp(r'[0-9]{9}$').hasMatch(val);
}

bool isPassportSeriesValidate(String val) {
  return RegExp(r'[0-9]{9}$').hasMatch(val);
}

bool isPassportNumberValidate(String val) {
  return RegExp(r'[0-9]{6}$').hasMatch(val);
}
