import 'package:conres_app/http.dart';
import 'package:conres_app/model/profile.dart';
import 'package:conres_app/model/result-data.dart';

class AuthRepo{
  final HttpClient httpClient;

  AuthRepo({required this.httpClient});

  Future<Object?>registration(Object sender) async{
    try{
      ResultData result = await httpClient.register(sender);
      if((result.code_msg?.custom_fields?.length)! > 0){
        return result.code_msg?.custom_fields;
      }
    } catch(e){
      throw Exception(e);
    }
    return null;

  }

  Future<Object> getCookies(String username, String password) async{
    var result = await httpClient.getCookies(username, password);
    if(result is List){
      return result;
    } else {
      throw Exception(result);
    }
  }

  Future<dynamic> login(List<dynamic> sender) async{
    var result = await httpClient.login(sender);
    if(result is Profile){
      return result;
    }
  }

}