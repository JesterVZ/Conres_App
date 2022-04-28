import 'package:conres_app/model/claim.dart';
import 'package:conres_app/model/profile.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'consts.dart';
import 'model/contract.dart';
import 'model/meter.dart';
import 'model/model.dart';
import 'model/result-data.dart';
import 'model/ticket.dart';

class HttpClient{
  static final String url = protocol + domain + 'lk/index.php?route=common/registration/api';
  static final String loginUri = protocol + domain + 'lk/index.php?route=common/login/api';

  final Dio _apiClient = _getDio(baseUrl: url);
  final CookieJar _cookieJar = _getCookieJar();

  static Dio _getDio({String? baseUrl}) {
    return Dio(BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: 30000,
      contentType: Headers.jsonContentType,
    ));
  }

  static CookieJar _getCookieJar(){
    return CookieJar();
  }

  Future<dynamic> bindNewLS(String accountNumber, String accountAddress) async{
    String uri = protocol + domain + 'lk/index.php?route=catalog/account_binding/api_bind_request';
    try{
      var formData = FormData.fromMap({
        'account_bind_number': accountNumber,
        'account_bind_address': accountAddress
      });
      final result = await _apiClient.post(uri, data: formData);
      if(result.statusCode == 200){
        print(result);
        return ResultData.fromMap(result.data);
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<dynamic> register(Object sender) async{
    if(sender is Fl){
      try{
        var formData = FormData.fromMap({
          'user_lk_group_id': '1',
          'user_lk_type_id': sender.User_lk_type_id,
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
          return ResultData.fromMap(response.data);
        }
      } catch(e){
        throw Exception(e);
      }
    }
    if(sender is Ip){
      try{
        var formData = FormData.fromMap({
          'user_lk_group_id': '2',
          'user_lk_type_id': sender.User_lk_type_id,
          'agree': '1',
          'lastname': sender.Family,
          'firstname': sender.Name,
          'patronymic': sender.Patronymic,
          'inn': sender.inn,
          'ogrn': sender.ogrnip,

          'contacts[0][value]': sender.tel,
          'contacts[0][contact_type_id]': '2',
          'contacts[0][flags][1]': '1',

          'contacts[1][contact_type_id]': '3',
          'contacts[1][flags][1]': '1',
          'contacts[1][flags][2]': '1',

          'proxy[lastname]': sender.dl?.Family,
          'proxy[firstname]': sender.dl?.Name,
          'proxy[patronymic]': sender.dl?.Patronymic,
          'proxy[telephone]': sender.dl?.TelDL,
          'proxy[email]': sender.dl?.EmailDL,

          'contacts[1][value]': sender.email,
          'password': sender.Password,
          'confirm': sender.RepeatPassword

        });
        var cookieJar=CookieJar();
        _apiClient.interceptors.add(CookieManager(cookieJar));
        final response = await _apiClient.post(url, data: formData);
        if(response.statusCode == 200){
          return ResultData.fromMap(response.data);
        }
      }catch(e){
        throw Exception(e);
      }
    }
    if(sender is Ul){
      try{
        var formData = FormData.fromMap({
          'user_lk_group_id': '2',
          'user_lk_type_id': '3',
          'agree': '1',
          'company_full': sender.FullName,
          'company_short': sender.Name,
          'inn': sender.Inn,
          'kpp': sender.Kpp,
          'ogrn': sender.Orgnip,

          'contacts[0][value]': sender.Tel,
          'contacts[0][contact_type_id]': '2',
          'contacts[0][flags][1]': '1',

          'proxy[lastname]': sender.dl?.Family,
          'proxy[firstname]': sender.dl?.Name,
          'proxy[patronymic]': sender.dl?.Patronymic,
          'proxy[telephone]': sender.dl?.TelDL,
          'proxy[email]': sender.dl?.EmailDL,

          'contacts[1][value]': sender.Email,
          'password': sender.Password,
          'confirm': sender.RepeatPassword
        });
        var cookieJar=CookieJar();
        _apiClient.interceptors.add(CookieManager(cookieJar));
        final response = await _apiClient.post(url, data: formData);
        if(response.statusCode == 200){
          return ResultData.fromMap(response.data);
        }
      }catch(e){
        throw Exception(e);
      }
    }
  }

  Future<dynamic> getCookies(String username, String password, int type) async{
    String uri = protocol + domain + 'lk/index.php?route=common/login/api';
    try{
      var formData = FormData.fromMap({
        'user_lk_type_id': type,
        'username': username,
        'password': password
      });
      _apiClient.interceptors.add(CookieManager(_cookieJar));
      final response = await _apiClient.post(uri, data: formData);
      if(response.statusCode == 200){
        if(response.data["code_result"] == 200){
          final cookies = await _cookieJar.loadForRequest(Uri.parse(uri));
          return cookies;
        } else {
          return "Ошибка получения cookie!";
        }
      }
    } catch(e){
      throw Exception("Ошибка получения cookie");
    }
  }

  Future<String> getCookieStringForWebSocket(String username, String password, int type) async{
    List<dynamic> cookies = await getCookies(username, password, type);

    String pf = cookies[2].value;
    String pa = cookies[3].value;
    String pc = cookies[4].value;
    String pp = cookies[5].value;
    String pd = cookies[6].value;

    String result = '{"cmd":"connect","cookie": "salp0-36=1; salp0-37=1; salp0-38=1; time_offset=5; pf=' +
        pf +
        '; pa=' +
        pa +
        '; pc=' +
        pc +
        '; pp='
        + pp +
        '; pd='
        + pd + '; currency=RUB; language=ru-ru; _ga=GA1.1.682084980.1646901701; time_offset=5; _ga_4LXS3K46R3=GS1.1.1648636976.49.0.1648637488.0"}';
    return result;
  }

  Future<Object?> login(List<dynamic> cookies) async{
    String uri = protocol + domain + 'lk/index.php?route=common/api/api_getInfo_old';
    try{
      final result = await _apiClient.post(uri);
      if(result.statusCode == 200){
        return Profile.fromMap(result.data['data']);
      }
      return null;
    }catch(e){
      throw Exception(e);
    }
  }

  Future<Object?> getTestimony() async{
    String uri = protocol + domain + 'lk/index.php?route=catalog/measures/api_form';
    try{
      final result = await _apiClient.post(uri);
      List<Meter> meters = [];
      if(result.statusCode == 200){
        for(int i = 0; i < result.data['data']['meters'].length; i++){
          Meter thisMeter = Meter.fromMap(result.data['data']['meters'][i]);
          thisMeter.lastReadings = await GetLastReadings(result.data['data']['lastReadings'], thisMeter);
          meters.add(thisMeter);
        }
        return meters;
      }
    }catch(e){
      return e.toString();
    }
    return null;
  }

  Future<LastReadings?> GetLastReadings(Map<String, dynamic> sender, Meter meter) async{
    LastReadings result;
    try{
      result = LastReadings.fromMap(sender[meter.meter_id][0]);
      return result;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<dynamic> getContracts() async{
    String uri = protocol + domain + 'lk/index.php?route=contracts/contracts/api_list';
    try{
      final result = await _apiClient.post(uri);
      List<Contract> contracts = [];
      if(result.statusCode == 200){
        for(int i = 0; i < result.data['data']['accounts'].length; i++){
          Contract thisContract = Contract.fromMap(result.data['data']['accounts'][i]);
          contracts.add(thisContract);
        }
        return contracts;
      }
    }catch(e){
      return e.toString();
    }
  }

  Future<Object?> getLinkedNumbers() async{
    String uri = protocol + domain + 'lk/index.php?route=common/api/api_getInfo';
    try{
      final result = await _apiClient.post(uri);
      if(result.statusCode == 200){
        List<String> numbers = [];
        for(int i = 0; i < result.data['data']['accounts_lk'].length; i++){
          numbers.add(result.data['data']['accounts_lk'][i]['account_number']);
        }
        return numbers;
      }
    }catch(e){
      print(e);
    }
  }

  Future<Object?>? getTickets() async{
    String uri = protocol + domain + 'lk/index.php?route=catalog/ticket/api_getTickets';
    try{
      final result = await _apiClient.post(uri);
      if(result.statusCode == 200){
        List<Ticket> tickets = [];
        for(int i = 0; i < result.data['data']['tickets'].length; i++){
          tickets.add(Ticket.fromMap(result.data['data']['tickets'][i]));
        }
        return tickets;
      }
    }catch(e){
      print(e);
    }
  }

  Future<Object?>? getMessagesFromTicket(String chat_id, String page, String last_message_id) async{
    String uri = protocol + domain + 'lk/index.php?route=catalog/ticket/api_getMessagesTicket';
    try{
      var formData = FormData.fromMap({
        'chat_id': chat_id,
        'type': 'scroll',
        'page': page,
        'last_message_id': last_message_id
      });
      final result = await _apiClient.post(uri, data: formData);
    }catch(e){
      print(e);
    }
  }

  Future<Object?> getClaims() async{
    String uri = protocol + domain + 'lk/index.php?route=claims/claims/api';
    try{
      final result = await _apiClient.post(uri);
      if(result.statusCode == 200){
        List<Claim> claims = [];
        for(int i = 0; i < result.data['data']['user_claims'].length; i++){
          claims.add(Claim.fromMap(result.data['data']['user_claims'][0]));
        }
        return claims;
      }
    }catch(e){
      print(e);
    }
  }

}