import 'dart:convert';
import 'dart:io';
import 'package:conres_app/model/claim-message.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:conres_app/model/store.dart';
import 'package:conres_app/model/user-information.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:open_file/open_file.dart';
import 'package:conres_app/model/claim.dart';
import 'package:conres_app/model/message.dart';
import 'package:conres_app/model/profile.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'consts.dart';
import 'model/contract.dart';
import 'model/counter.dart';
import 'model/meter.dart';
import 'model/model.dart';
import 'model/result-data.dart';
import 'model/ticket.dart';

class HttpClient{
  //static final String url = domain + 'lk/index.php?route=common/registration/api';
  static final String loginUri = domain + 'lk/index.php?route=common/login/api';

  final Dio _apiClient = _getDio(baseUrl: '');
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
    String uri = domain + 'lk/index.php?route=catalog/account_binding/api_bind_request';
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
      return e;
    }
  }

  Future<dynamic> register(Object sender) async{
    String url = domain + 'lk/index.php?route=common/registration/api';
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
        return e;
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
        return e;
      }
    }
    if(sender is Ul){
      try{
        var formData = FormData.fromMap({
          'user_lk_group_id': '3',
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
          'contacts[0][flags][2]': '1',

          'contacts[1][contact_type_id]': '3',
          'contacts[1][flags][1]': '1',
          'contacts[1][flags][2]': '1',
          'contacts[1][value]': sender.Email,
          
          'proxy[lastname]': sender.dl?.Family,
          'proxy[firstname]': sender.dl?.Name,
          'proxy[patronymic]': sender.dl?.Patronymic,
          'proxy[telephone]': sender.dl?.TelDL,
          'proxy[email]': sender.dl?.EmailDL,

          
          'password': sender.Password,
          'confirm': sender.RepeatPassword,
        });
        var cookieJar=CookieJar();
        _apiClient.interceptors.add(CookieManager(cookieJar));
        final response = await _apiClient.post(url, data: formData);
        if(response.statusCode == 200){
          return ResultData.fromMap(response.data);
        }
      }catch(e){
        return e;
      }
    }
  }

  Future<dynamic> getCookies(String username, String password, int type) async{
    String uri = domain + 'lk/index.php?route=common/login/api';
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
          return "Неправильный логин или пароль!";
        }
      }
    } catch(e){
      return e;
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
    String uri = domain + 'lk/index.php?route=common/api/api_getInfo_old';
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


/*
  Future<Object?> getTestimony() async{
    String uri = domain + 'lk/index.php?route=catalog/measures/api_form';
    try{
      final result = await _apiClient.post(uri);
      List<Meter> meters = [];
      if(result.statusCode == 200){
        
        if(result.data['data']['meters'].length > 0){
            for(int i = 0; i < result.data['data']['meters'].length; i++){
            Meter thisMeter = Meter.fromMap(result.data['data']['meters'][i]);
            thisMeter.lastReadings = await GetLastReadings(result.data['data']['lastReadings'], thisMeter);
            meters.add(thisMeter);
          }
        }

        return meters;
      }
    }catch(e){
      return e.toString();
    }
    return null;
  }
*/
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
    String uri = domain + 'lk/index.php?route=contracts/contracts/api_list';
    try{
      final result = await _apiClient.post(uri);
      List<Contract> contracts = [];
      if(result.statusCode == 200){
        for(int i = 0; i < result.data['data']['accounts'].length; i++){
          Contract thisContract = Contract.fromMap(result.data['data']['accounts'][i]);
          thisContract.isCurrent = result.data['data']['account_number'] == thisContract.account_number! ? true : false;
          contracts.add(thisContract);
        }
        return contracts;
      }
    }catch(e){
      return e.toString();
    }
  }

  Future<Object?> getInfo() async{
    String uri = domain + 'lk/index.php?route=common/api/api_getInfo';
    try{
      final result = await _apiClient.post(uri);
      if(result.statusCode == 200){
        return ResultData.fromMap(result.data);
      }
    }catch(e){
      return e;
    }
  }

  Future<Object?>? getTickets(String page) async{
    String uri = domain + 'lk/index.php?route=catalog/ticket/api_getTickets';
    try{
      var formData = FormData.fromMap({
        'page': page
      });
      final result = await _apiClient.post(uri, data: formData);
      if(result.statusCode == 200){
        List<Ticket> tickets = [];
        for(int i = 0; i < result.data['data']['tickets'].length; i++){
          tickets.add(Ticket.fromMap(result.data['data']['tickets'][i]));
        }
        return tickets;
      }
    }catch(e){
      return e;
    }
  }

  Future<Object?>? getMessagesFromTicket(String chat_id, String page, String last_message_id) async{
    String uri = domain + 'lk/index.php?route=catalog/ticket/api_getMessagesTicket';
    try{
      var formData = FormData.fromMap({
        'chat_id': chat_id,
        'type': 'scroll',
        'page': page,
        'last_message_id': last_message_id
      });
      final result = await _apiClient.post(uri, data: formData);
      if(result.statusCode == 200){
        List<TicketMessage> messages = [];
        for(int i = 0; i < result.data['data']['messages'].length; i++){
          messages.add(TicketMessage.fromMap(result.data['data']['messages'][i]));
        }
        TicketFullInfo fullInfo = TicketFullInfo(
          messages: messages, 
          messages_more: result.data['data']['messages_more'],
          messages_page: result.data['data']['messages_page'],
          last_message_id: result.data['data']['last_message_id'],
          last_read_msg: result.data['data']['last_read_msg'],
          ticket_is_closed: result.data['data']['ticket_is_closed']);
        return fullInfo;
      }
    }catch(e){
      return e;
    }
  }

  Future<Object?> getClaims() async{
    String uri = domain + 'lk/index.php?route=claims/claims/api';
    try{
      final result = await _apiClient.post(uri);
      if(result.statusCode == 200){
        List<Claim> claims = [];
        for(int i = 0; i < result.data['data']['user_claims'].length; i++){
          claims.add(Claim.fromMap(result.data['data']['user_claims'][i]));
        }
        return claims;
      }
    }catch(e){
      return e;
    }
  }

  Future<Object?> sendMessage(String ticketId, String message, String ticketStatusId, List<dynamic>? files) async{
    String uri = domain + 'lk/index.php?route=catalog/ticket/sendMessage';
    try{
      var formData;
      if(files == null){
        formData = FormData.fromMap({
        'ticket_id': ticketId,
        'message': message, 
        'ticket_status_id': ticketStatusId
      });
      } else {
        formData = FormData.fromMap({
        'contract_files_name[]': files[0].path!.split('/').last, //имя файла
        'contract_files[]': await MultipartFile.fromFile(files[0].path!, filename: files[0].path!.split('/').last),
        'ticket_id': ticketId,
        'message': message, 
        'ticket_status_id': ticketStatusId
      });
      }
      final result = await _apiClient.post(uri, data: formData);
      if(result.statusCode == 200){
        return json.decode(result.data);
      }
    }catch(e){
      return e.toString();
    }
  }


  Future<Object?> setReadMessage(String ticketId, String messageId) async{
    String uri = domain + 'lk/index.php?route=catalog/ticket/api_setReadMessage';
    try{
      var formData = FormData.fromMap({
        'ticket_id': ticketId,
        'message_id': messageId,
      });
      final result = await _apiClient.post(uri, data: formData);
      if(result.statusCode == 200){

      }
    }catch(e){
      return e;
    }
  }
  Future<Object?> download(String uri, String fileName) async{
    try {
      final dir = await getExternalStorageDirectory();
      final isPermissionStatusGranted = await _requestPermissions();
      if (isPermissionStatusGranted) {
        bool isExists = await File(dir!.path + '/$fileName').exists();
        if (isExists) {
          var result = await OpenFile.open(dir.path + '/$fileName');
        } else {
          final response = await _apiClient.download(
              uri, dir.path + '/$fileName', onReceiveProgress: (rec, total) {
            print((rec / total) * 100);
          });
          await OpenFile.open(dir.path + '/$fileName');
        }
      }
    } catch (e) {
      return e;
    }
  }

  Future<Object?> getFullProfileInfo() async{
    String uri = domain + 'lk/index.php?route=catalog/user_information/api_get';
    final result = await _apiClient.post(uri);
    if(result.statusCode == 200){
      return UserInformation.fromMap(result.data['data']);
    } else {
      throw Exception();
    }
  }

  Future<Object?> getObjectsPU () async{
    String uri = domain + 'lk/index.php?route=catalog/objects/api_list';
    try{
      final result = await _apiClient.post(uri);
      if(result.statusCode == 200){
        List<ObjectPuModel> objects = [];
        if(result.data['data']['objects'].length > 0){
          for(int i = 0; i < result.data['data']['objects'].length; i++){
            objects.add(ObjectPuModel.fromMap(result.data['data']['objects'][i]));
          }
          return objects;
        }
      }
    }catch(e){
      return(e);
    }

  }
    Future<Object?> getMeters() async{
    String uri = domain + 'lk/index.php?route=catalog/measures/api_form';
    try{
      final result = await _apiClient.post(uri);
      List<Meter> meters = [];
      if(result.statusCode == 200){
        
        if(result.data['data']['meters'].length > 0){
            for(int i = 0; i < result.data['data']['meters'].length; i++){
            Meter thisMeter = Meter.fromMap(result.data['data']['meters'][i]);
            thisMeter.lastReadings = await GetLastReadings(result.data['data']['lastReadings'], thisMeter);
            meters.add(thisMeter);
          }
        }

        return meters;
      }
    }catch(e){
      return e.toString();
    }
    return null;
  }

  Future<Object?> addTicket(String contact_email, String contact_name, String ticket_theme_id, String message) async{
    String uri = domain + 'lk/index.php?route=catalog/ticket/api_addTicket';
    try{
      var formData = FormData.fromMap({
        'contact_email': contact_email,
        'contact_name': contact_name,
        'ticket_theme_id': ticket_theme_id,
        'message': message
      });
      final result = await _apiClient.post(uri, data: formData);
    }catch(e){
      return e.toString();
    }
  }


  Future<bool> _requestPermissions() async {
    var permission = await Permission.storage.request();
    if(permission.isGranted){
      return true;
    } else {
      return false;
    }
  }

  Future<Object?> getStors() async{
    String uri = "https://dev.conres.ru/backmanager/index.php?route=common/api/api_get_stores";
    final result = await _apiClient.post(uri);
    List<Store> stores = [];
    if(result.statusCode == 200){
      for(int i = 0; i < result.data['data']['stores'].length; i++){
        stores.add(Store.fromMap(result.data['data']['stores'][i]));
      }
      return stores;
    }
  }

  Future<Object?> getMessagesFromClaim(String claim_id) async{
    String uri = domain + 'lk/index.php?route=claims/claims/api_getClaimMessages';
    var formData = FormData.fromMap({
      'claim_id': claim_id
    });
    final result = await _apiClient.post(uri, data: formData);
    List<ClaimMessage> messages = [];
    if(result.statusCode == 200){
      for(int i = 0; i < result.data['data']['messages'].length; i++){
        messages.add(ClaimMessage.fromMap(result.data['data']['messages'][i]));
      }
      return messages;
    }
  }

  Future<Object?> sendClaimMessage(String claim_id, String text, List<PlatformFile>? files) async{
    String uri = domain + 'lk/index.php?route=claims/claims/api_sendMessage';
    try{
      var formData;
      if(files == null){
        formData = FormData.fromMap({
        'claim_id': claim_id,
        'text': text, 
      });
      } else {
        formData = FormData.fromMap({
        'contract_files_name[]': files[0].path!.split('/').last, //имя файла
        'contract_files[]': await MultipartFile.fromFile(files[0].path!, filename: files[0].path!.split('/').last),
        'claim_id': claim_id,
        'text': text, 
      });
      }
      final result = await _apiClient.post(uri, data: formData);
      if(result.statusCode == 200){
        return result.data;
      }
    }catch(e){
      return e.toString();
    }
  }
}