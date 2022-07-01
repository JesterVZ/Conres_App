bool isEmailValidate(String val){
  return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val);
}

bool isPhoneValidate(String val){
  return RegExp(r'[0-9\-\+]{9,15}$').hasMatch(val);
}

bool isSnilsValidate(String val){
  return RegExp(r'[0-9]{3}[\s\-][0-9]{3}[\s\-][0-9]{3}[\s\-][0-9]{2}$').hasMatch(val);
}

bool isInnValidate(String val){
  return RegExp(r'[0-9]{12}$').hasMatch(val);
}

bool isOgrnipValidate(String val){
  return RegExp(r'[0-9]{15}$').hasMatch(val);
}

bool isKppValidate(String val){
  return RegExp(r'[0-9]{9}$').hasMatch(val);
}

bool isLsvalidate(String val){
  return RegExp(r'[0-9]{9}$').hasMatch(val);
}

bool isPassportSeriesValidate(String val){
  return RegExp(r'[0-9]{4}$').hasMatch(val);
}

bool isPassportNumberValidate(String val){
  return RegExp(r'[0-9]{6}$').hasMatch(val);
}