import 'package:shared_preferences/shared_preferences.dart';

Future<bool?> isGetLogin(SharedPreferences preferences) async{
  final bool? result = await preferences.getBool("isLogin");
  return result;
}

void setLogin(SharedPreferences preferences, String login, String password) async{
  await preferences.setString('login', login);
  await preferences.setString('password', password);
  await preferences.setBool('isLogin', true);
}

Future<dynamic> getLogin(SharedPreferences preferences) async{
  final login = await preferences.getString('login');
  final password = await preferences.getString('password');

  List<dynamic> result = [
    login,
    password
  ];

  return result;
}

void Logout(SharedPreferences preferences) async{
  await preferences.remove('isLogin');
}