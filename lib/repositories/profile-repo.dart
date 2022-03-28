import 'package:conres_app/http.dart';
import '../shared-preferences/shared-preferences.dart';

class ProfileRepo{
  final HttpClient httpClient;

  ProfileRepo({required this.httpClient});

  Future<String>getCookie(String username, String password, int type) async{
    String result = await httpClient.getCookieStringForWebSocket(username, password, type);
    return result;
  }
  Future<dynamic> loginData() async {
    var result = await getLogin();
    if (result is List<dynamic>) {
      return result;
    }
  }
}