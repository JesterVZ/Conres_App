import 'package:conres_app/http.dart';
import 'package:conres_app/model/profile.dart';
import 'package:conres_app/model/result-data.dart';

class AuthRepo{
  final HttpClient httpClient;

  AuthRepo({required this.httpClient});

  Future<Object>registration(Object sender) async{
    var result = await httpClient.register(sender);
    if(result is ResultData){
      return result;
    } else {
      throw Exception(result);
    }
  }

  Future<Object> getCookies(String username, String password) async{
    var result = await httpClient.getCookies(username, password);
    if(result is List){
      return result;
    } else {
      throw Exception(result);
    }
  }

  Future<dynamic> login(List<Object> sender) async{
    var result = await httpClient.login(sender);
    if(result is Profile){
      return result;
    }
  }

}