import 'package:shared_preferences/shared_preferences.dart';

Future<bool?> isGetLogin() async{
  final prefs = await SharedPreferences.getInstance();
  final bool? result = prefs.getBool("login");
  return result;
}