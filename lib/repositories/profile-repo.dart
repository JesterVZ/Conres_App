import 'package:conres_app/http.dart';

class ProfileRepo{
  final HttpClient httpClient;

  ProfileRepo(this.httpClient);

  Future<String>getCookie(String uri) async{
    String result = await httpClient.getCookieStringForWebSocket(uri);
    return result;
  }
}