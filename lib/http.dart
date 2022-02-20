import 'package:conres_app/model/profile.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'consts.dart';
import 'model/model.dart';
import 'model/result-data.dart';

class HttpClient{
  static final String url = protocol + domain + 'lk/index.php?route=common/registration/api';

  final Dio _apiClient = _getDio(baseUrl: url);

  static Dio _getDio({String? baseUrl}) {
    return Dio(BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: 30000,
      contentType: Headers.jsonContentType,
    ));
  }

  Future<dynamic> register(Object sender) async{
    if(sender is Fl){
      try{
        var formData = FormData.fromMap({
          'user_lk_group_id': '1',
          'user_lk_type_id': '1',
          'agree': '1',
          'lastname': sender.Family,
          'firstname': sender.Name,
          'patronymic': sender.Patronymic,
          'inn': sender.Inn,
          'snils': sender.Snils,

          'contacts[0][value]': sender.Tel,
          'contacts[0][contact_type_id]': '2',
          'contacts[0][flags][1]': '1',

          'contacts[1][contact_type_id]': '3',
          'contacts[1][flags][1]': '1',
          'contacts[1][flags][2]': '1',

          'contacts[1][value]': sender.Email,
          'password': sender.Password,
          'confirm': sender.RepeatPassword

        });
        var cookieJar=CookieJar();
        _apiClient.interceptors.add(CookieManager(cookieJar));
        final response = await _apiClient.post(url, data: formData);
        if(response.statusCode == 200){
          if(response.data["code_result"] == 200){
            return ResultData.fromMap(response.data);
          } else if(response.data["code_result"] == 300) {
            return "Ошибка регистрации";
          }

        }
      } catch(e){
        throw Exception(e);
      }
    }
  }

  Future<dynamic> getCookies(String username, String password) async{
    String uri = protocol + domain + 'lk/index.php?route=common/login/api';
    var dio = Dio(BaseOptions(
      connectTimeout: 30000,
      contentType: Headers.jsonContentType,
    ));
    try{
      var formData = FormData.fromMap({
        'user_lk_type_id': '2',
        'username': username,
        'password': password
      });
      var cookieJar=CookieJar();
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio.post(uri, data: formData);
      if(response.statusCode == 200){
        if(response.data["code_result"] == 200){
          final cookies = await cookieJar.loadForRequest(Uri.parse(uri));
          return cookies;
        } else {
          return "Ошибка логина";
        }
      }
    } catch(e){
      throw Exception("Ошибка");
    }
  }

  Future<dynamic>? login(List<dynamic> cookies){
    return Profile(

    );
  }

}