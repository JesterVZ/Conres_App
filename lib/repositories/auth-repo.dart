import 'package:conres_app/http.dart';
import 'package:conres_app/model/profile.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/meter.dart';
import '../shared-preferences/shared-preferences.dart';

class AuthRepo {
  final HttpClient httpClient;

  AuthRepo({required this.httpClient});

  Future<Object?> registration(Object sender) async {
    ResultData result;
    try {
      result = await httpClient.register(sender);
      if ((result.code_msg?.custom_fields?.length)! > 0) {
        return result.code_msg?.custom_fields;
      }
    } catch (e) {
      throw Exception(e);
    }
    return result;
  }

  Future<Object> getCookies(String username, String password, int type) async {
    var result = await httpClient.getCookies(username, password, type);
    return result;
  }

  Future<dynamic> login(List<dynamic> sender) async {
    var result = await httpClient.login(sender);
    if (result is Profile) {
      return result;
    }
  }

  Future<bool?> isLogin(SharedPreferences preferences) async {
    bool? result = await isGetLogin(preferences);
    return result;
  }

  Future<dynamic> loginData() async {
    var result = await getLogin();
    if (result is List<dynamic>) {
      return result;
    }
  }

  Future<Object?> getTestimonyFunc() async {
    var result = await httpClient.getTestimony();
    return result;
  }

}
