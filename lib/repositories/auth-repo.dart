import 'package:conres_app/bloc/auth/auth-event.dart';
import 'package:conres_app/http.dart';
import 'package:conres_app/model/profile.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/meter.dart';
import '../shared-preferences/shared-preferences.dart';
/* 
auth-repo.dart
Auth репозиторий

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
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

  Future<dynamic> login() async {
    var result = await httpClient.login();
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

  Future<Object?> getStores() async {
    var result = await httpClient.getStors();
    return result;
  }
}
