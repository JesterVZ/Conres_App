
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool?> isGetLogin(SharedPreferences preferences) async{
  bool? result = await preferences.getBool("isLogin");
  return result;
}

void setLogin(SharedPreferences preferences, String login, String password, int type) async{
  await preferences.setString('login', login);
  await preferences.setString('password', password);
  await preferences.setInt('type', type);
  await preferences.setBool('isLogin', true);
}

Future<List<dynamic>?> getLogin() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool? isLogin = await isGetLogin(preferences);
  if(isLogin == true){
    final login = await preferences.getString('login');
    final password = await preferences.getString('password');
    final type = await preferences.getInt('type');
    List<dynamic> result = [
      login,
      password,
      type
    ];

    return result;
  } else {
    return null;
  }

}

Future logoutFunc(SharedPreferences preferences) async{
  await preferences.remove('login');
  await preferences.remove('password');
  await preferences.remove('type');
  await preferences.remove('isLogin');
}