import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'consts.dart';

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