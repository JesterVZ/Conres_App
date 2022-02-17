
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'consts.dart';
import 'model/model.dart';
import 'model/result-dara.dart';

Future<String> loginfunc(String username, String password) async {
  String uri = protocol + domain + 'lk/index.php?route=common/login/api';
  var dio = Dio(BaseOptions(
    connectTimeout: 30000,
    contentType: Headers.jsonContentType,
  ));
  var formData = FormData.fromMap({
    'user_lk_type_id': '2',
    'username': username,
    'password': password
  });
  var cookieJar=CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));

  final response = await dio.post(uri, data: formData);
  if(response.statusCode == 200){

  }
  final cookies = await cookieJar.loadForRequest(Uri.parse(uri));
  return "";
}

Future<Object> registrationFunc(Object object) async{
  String uri = protocol + domain + 'lk/index.php?route=common/registration/api';
  var dio = Dio(BaseOptions(
    connectTimeout: 30000,
    contentType: Headers.jsonContentType,
  ));
  var formData;
  if(object is Fl){
    formData = FormData.fromMap({
      'user_lk_group_id': '1',
      'user_lk_type_id': '1',
      'agree': '1',
      'lastname': object.Family,
      'firstname': object.Name,
      'patronymic': object.Patronymic,
      'inn': object.Inn,
      'snils': object.Snils,

      'contacts[0][value]': object.Tel,
      'contacts[0][contact_type_id]': '2',
      'contacts[0][flags][1]': '1',

      'contacts[1][contact_type_id]': '3',
      'contacts[1][flags][1]': '1',
      'contacts[1][flags][2]': '1',

      'contacts[1][value]': object.Email,
      'password': object.Password,
      'confirm': object.RepeatPassword

    });
  }
  var cookieJar=CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));

  try{
    final response = await dio.post(uri, data: formData);
    if(response.statusCode == 200){
      if(response.data["code_result"] == 200){
        return ResultData.fromMap(response.data);
      } else if(response.data["code_result"] == 300) {
        return "Ошибка регистрации";
      } else{
        return "Неизвестная ошибка";
      }

    }
  }catch(e){
    throw Exception();
  }
  return "";

}