import 'dart:convert';
import 'dart:io';
import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/DI/locator.dart';
import 'package:conres_app/Services/main-claim-send-service.dart';
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

import 'Services/base-claim-send-service.dart';
import 'consts.dart';
import 'model/TU.dart';
import 'model/contract.dart';
import 'model/counter.dart';
import 'model/meter.dart';
import 'model/model.dart';
import 'model/result-data.dart';
import 'model/ticket.dart';

class HttpClient {
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

  static CookieJar _getCookieJar() {
    return CookieJar();
  }

  Future<dynamic> bindNewLS(String accountNumber, String accountAddress) async {
    String uri =
        domain + 'lk/index.php?route=catalog/account_binding/api_bind_request';
    try {
      var formData = FormData.fromMap({
        'account_bind_number': accountNumber,
        'account_bind_address': accountAddress
      });
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {
        return result.data['data'];
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> bindNewObject(String objectName, String objectAddress) async {
    String uri = domain + 'lk/index.php?route=catalog/objects/api_bind_request';
    try {
      var formData = FormData.fromMap({
        'new_object_name': objectName,
        'new_object_address': objectAddress,
        'isMobile': '1'
      });
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {
        return result.data['data'];
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> bindNewTU(String object_id, String new_tu_number, String new_tu_name, String new_tu_address) async {
    String uri = domain + 'lk/index.php?route=catalog/pu_info/api_bind_request_tu';
    try {
      var formData = FormData.fromMap({
        'object_id': object_id,
        'new_tu_number': new_tu_number,
        'new_tu_name': new_tu_name,
        'new_tu_address': new_tu_address,
        'isMobile': '1'
      });
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {
        return result.data['data'];
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> register(Object sender) async {
    String url = domain + 'lk/index.php?route=common/registration/api';
    if (sender is Fl) {
      try {
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
        var cookieJar = CookieJar();
        _apiClient.interceptors.add(CookieManager(cookieJar));
        final response = await _apiClient.post(url, data: formData);
        if (response.statusCode == 200) {
          return ResultData.fromMap(response.data);
        }
      } catch (e) {
        return e;
      }
    }
    if (sender is Ip) {
      try {
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
        var cookieJar = CookieJar();
        _apiClient.interceptors.add(CookieManager(cookieJar));
        final response = await _apiClient.post(url, data: formData);
        if (response.statusCode == 200) {
          return ResultData.fromMap(response.data);
        }
      } catch (e) {
        return e;
      }
    }
    if (sender is Ul) {
      try {
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
        var cookieJar = CookieJar();
        _apiClient.interceptors.add(CookieManager(cookieJar));
        final response = await _apiClient.post(url, data: formData);
        if (response.statusCode == 200) {
          return ResultData.fromMap(response.data);
        }
      } catch (e) {
        return e;
      }
    }
  }

  Future<dynamic> getCookies(String username, String password, int type) async {
    String uri = domain + 'lk/index.php?route=common/login/api';
    try {
      var formData = FormData.fromMap({
        'user_lk_type_id': type,
        'username': username,
        'password': password
      });
      _apiClient.interceptors.add(CookieManager(_cookieJar));
      final response = await _apiClient.post(uri, data: formData);
      if (response.statusCode == 200) {
        if (response.data["code_result"] == 200) {
          var cookies = [];
          cookies = await _cookieJar.loadForRequest(Uri.parse(uri));
          cookiesList = cookies;
          return cookies;
        } else {
          return "Неправильный логин или пароль!";
        }
      }
    } catch (e) {
      return e;
    }
  }

  Future<String> getCookieStringForWebSocket(List cookies) async {
    String pf = cookies[2].value;
    String pa = cookies[3].value;
    String pc = cookies[4].value;
    String pp = cookies[5].value;
    String pd = cookies[6].value;

    String result =
        '{"cmd":"connect","cookie": "salp0-36=1; salp0-37=1; salp0-38=1; time_offset=5; pf=' +
            pf +
            '; pa=' +
            pa +
            '; pc=' +
            pc +
            '; pp=' +
            pp +
            '; pd=' +
            pd +
            '; currency=RUB; language=ru-ru; _ga=GA1.1.682084980.1646901701; time_offset=5; _ga_4LXS3K46R3=GS1.1.1648636976.49.0.1648637488.0"}';
    return result;
  }

  Future<Object?> login() async {
    String uri = domain + 'lk/index.php?route=common/api/api_getInfo_old';
    try {
      final result = await _apiClient.post(uri);
      if (result.statusCode == 200) {
        return Profile.fromMap(result.data['data']);
      }
      return null;
    } catch (e) {
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
  Future<LastReadings?> GetLastReadings(
      Map<String, dynamic> sender, Meter meter) async {
    LastReadings result;
    try {
      result = LastReadings.fromMap(sender[meter.meter_id][0]);
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getContracts() async {
    String uri = domain + 'lk/index.php?route=contracts/contracts/api_list';
    try {
      final result = await _apiClient.post(uri);
      List<Contract> contracts = [];
      if (result.statusCode == 200) {
        for (int i = 0; i < result.data['data']['accounts'].length; i++) {
          Contract thisContract =
              Contract.fromMap(result.data['data']['accounts'][i]);
          thisContract.isCurrent = result.data['data']['account_number'] ==
                  thisContract.account_number!
              ? true
              : false;
          contracts.add(thisContract);
        }
        return contracts;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> hideAccount(String account_id) async {
    String uri = domain +
        'lk/index.php?route=contracts/contracts/api_hidden_acc_request';
    var formData = FormData.fromMap({'account_id': account_id});
    final result = await _apiClient.post(uri, data: formData);
    if (result.statusCode == 200) {
      return true;
    }
  }

  Future<dynamic> hideObject(String object_id) async {
    String uri = domain +
        'lk/index.php?route=catalog/objects/api_deleteObject';
    var formData = FormData.fromMap({'object_id': object_id, 'isMobile': '1'});
    final result = await _apiClient.post(uri, data: formData);
    if (result.statusCode == 200) {
      return true;
    }
  }

  Future<Object?> getInfo() async {
    String uri = domain + 'lk/index.php?route=common/api/api_getInfo';
    try {
      final result = await _apiClient.post(uri);
      if (result.statusCode == 200) {
        return result.data['data'];
      }
    } catch (e) {
      return e;
    }
  }

  Future<Object?>? getTickets(String page) async {
    String uri = domain + 'lk/index.php?route=catalog/ticket/api_getTickets';
    try {
      var formData = FormData.fromMap({'page': page});
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {
        List<Ticket> tickets = [];
        for (int i = 0; i < result.data['data']['tickets'].length; i++) {
          tickets.add(Ticket.fromMap(result.data['data']['tickets'][i]));
        }
        return tickets;
      }
    } catch (e) {
      return e;
    }
  }

  Future<Object?>? getMessagesFromTicket(
      String chat_id, String page, String last_message_id) async {
    String uri =
        domain + 'lk/index.php?route=catalog/ticket/api_getMessagesTicket';
    try {
      var formData = FormData.fromMap({
        'chat_id': chat_id,
        'type': 'scroll',
        'page': page,
        'last_message_id': last_message_id
      });
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {
        List<TicketMessage> messages = [];
        for (int i = 0; i < result.data['data']['messages'].length; i++) {
          messages
              .add(TicketMessage.fromMap(result.data['data']['messages'][i]));
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
    } catch (e) {
      return e;
    }
  }

  Future<Object?> getClaims() async {
    String uri = domain + 'lk/index.php?route=claims/claims/api';
    try {
      final result = await _apiClient.post(uri);
      if (result.statusCode == 200) {
        List<Claim> claims = [];
        for (int i = 0; i < result.data['data']['user_claims'].length; i++) {
          claims.add(Claim.fromMap(result.data['data']['user_claims'][i]));
        }
        return claims;
      }
    } catch (e) {
      return e;
    }
  }

  Future<Object?> sendMessage(String ticketId, String message,
      String ticketStatusId, dynamic file) async {
    String uri = domain + 'lk/index.php?route=catalog/ticket/sendMessage';
    try {
      var formData;
      if (file == null) {
        formData = FormData.fromMap({
          'ticket_id': ticketId,
          'message': message,
          'ticket_status_id': ticketStatusId
        });
      } else {
        formData = FormData.fromMap({
          'contract_files_name[]': file.path!.split('/').last, //имя файла
          'contract_files[]': await MultipartFile.fromFile(file.path!,
              filename: file.path!.split('/').last),
          'ticket_id': ticketId,
          'message': message,
          'ticket_status_id': ticketStatusId
        });
      }
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {
        return json.decode(result.data);
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Object?> sendTestimony(
      List<String> dayValues, List<String> nightValues) async {
    String uri =
        domain + 'lk/index.php?route=catalog/measures/api_measure_send';
    var formData;
    Map<String, dynamic> map = Map<String, dynamic>();
    for (int i = 0; i < dayValues.length; i++) {
      final dayEntries = <String, dynamic>{
        "new_measures_${i + 1}[0]": dayValues[i]
      };
      final nightEntries = <String, dynamic>{
        "new_measures_${i + 1}[1]": nightValues[i]
      };
      map.addEntries(dayEntries.entries);
      map.addEntries(nightEntries.entries);
    }

    formData = map;
    final result = await _apiClient.post(uri, data: formData);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Object?> editMessage(String ticketId, String message,
      String ticketStatusId, dynamic file) async {
    String uri = domain + 'lk/index.php?route=catalog/ticket/editMessage';
    try {
      var formData;
      if (file == null) {
        formData = FormData.fromMap({
          'ticket_id': ticketId,
          'message': message,
          'ticket_status_id': ticketStatusId
        });
      } else {
        formData = FormData.fromMap({
          'contract_files_name[]': file.path!.split('/').last, //имя файла
          'contract_files[]': await MultipartFile.fromFile(file.path!,
              filename: file.path!.split('/').last),
          'ticket_id': ticketId,
          'message': message,
          'ticket_status_id': ticketStatusId
        });
      }
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {
        return json.decode(result.data);
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Object?> setReadMessage(String ticketId, String messageId) async {
    String uri =
        domain + 'lk/index.php?route=catalog/ticket/api_setReadMessage';
    try {
      var formData = FormData.fromMap({
        'ticket_id': ticketId,
        'message_id': messageId,
      });
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {}
    } catch (e) {
      return e;
    }
  }

  Future<Object?> setReadClaimMessage(String claimId, String messageId) async {
    String uri = domain + 'lk/index.php?route=claims/claims/api_setReadMessage';
    try {
      var formData = FormData.fromMap({
        'claim_id': claimId,
        'message_id': messageId,
      });
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {}
    } catch (e) {
      return e;
    }
  }

  Future<Object?> download(String uri, String fileName) async {
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

  Future<Object?> getFullProfileInfo() async {
    String uri = domain + 'lk/index.php?route=catalog/user_information/api_get';
    final result = await _apiClient.post(uri);
    if (result.statusCode == 200) {
      UserInformation userInformation = UserInformation.fromMap(result.data['data']);
      userInformation.user_info_contacts = [];
      for(int i = 0; i < result.data['data']['user_info_contacts'].length; i++){
        userInformation.user_info_contacts!.add(Contact.fromMap(result.data['data']['user_info_contacts'][i]));
      }
      return userInformation;
    } else {
      throw Exception();
    }
  }

  Future<Object?> getTU() async {
    String uri = domain + 'lk/index.php?route=catalog/objects/api_list';
    try {
      final result = await _apiClient.post(uri);
      if (result.statusCode == 200) {
        List<TuModel> objects = [];

        if (result.data['data']['list_tu'].length > 0) {
          for (int i = 0; i < result.data['data']['list_tu'].length; i++) {
            objects.add(TuModel.fromMap(result.data['data']['list_tu'][i]));
          }
          return objects;
        }
      }
    } catch (e) {
      return (e);
    }
  }

  Future<Object?> getPrivatePolicy() async {
    String uri = domain + 'lk/index.php?route=common/registration/api_getPdn';

    try {
      final result = await _apiClient.post(uri);
      if (result.statusCode == 200) {
        return result.data['data']['information_pdn_info']['description'];
      }
    } catch (e) {
      return (e);
    }
  }

  Future<Object?> getObjectsPU() async {
    String uri = domain + 'lk/index.php?route=catalog/objects/api_list';
    try {
      final result = await _apiClient.post(uri);
      if (result.statusCode == 200) {
        List<ObjectPuModel> objects = [];
        if (result.data['data']['objects'] != null) {
          if (result.data['data']['objects'].length > 0) {
            for (int i = 0; i < result.data['data']['objects'].length; i++) {
              objects.add(
                  ObjectPuModel.fromMap(result.data['data']['objects'][i]));
            }
          }
        }
        return objects;
      }
    } catch (e) {
      return (e);
    }
  }

  Future<Object?> getMeters() async {
    String uri = domain + 'lk/index.php?route=catalog/measures/api_form';
    try {
      final result = await _apiClient.post(uri);
      List<Meter> meters = [];
      if (result.statusCode == 200) {
        if (result.data['data']['meters'].length > 0) {
          for (int i = 0; i < result.data['data']['meters'].length; i++) {
            Meter thisMeter = Meter.fromMap(result.data['data']['meters'][i]);
            thisMeter.lastReadings = await GetLastReadings(
                result.data['data']['lastReadings'], thisMeter);
            meters.add(thisMeter);
          }
        }

        return meters;
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<Object?> addTicket(String contact_email, String contact_name,
      String ticket_theme_id, String message) async {
    String uri = domain + 'lk/index.php?route=catalog/ticket/api_addTicket';
    try {
      var formData = FormData.fromMap({
        'contact_email': contact_email,
        'contact_name': contact_name,
        'ticket_theme_id': ticket_theme_id,
        'message': message,
        'isMobile': '1'
      });
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {
        return result.data['data'];
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> _requestPermissions() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<Object?> getStors() async {
    String uri =
        "https://dev.conres.ru/backmanager/index.php?route=common/api/api_get_stores";
    final result = await _apiClient.post(uri);
    List<Store> stores = [];
    if (result.statusCode == 200) {
      for (int i = 0; i < result.data['data']['stores'].length; i++) {
        stores.add(Store.fromMap(result.data['data']['stores'][i]));
      }
      return stores;
    }
  }

  Future<Object?> getMessagesFromClaim(String claim_id) async {
    String uri =
        domain + 'lk/index.php?route=claims/claims/api_getClaimMessages';
    var formData = FormData.fromMap({'claim_id': claim_id});
    final result = await _apiClient.post(uri, data: formData);
    List<ClaimMessage> messages = [];
    if (result.statusCode == 200) {
      for (int i = 0; i < result.data['data']['messages'].length; i++) {
        messages.add(ClaimMessage.fromMap(result.data['data']['messages'][i]));
      }
      return messages;
    }
  }

  Future<Object?> sendClaimMessage(
      String claim_id, String text, dynamic file) async {
    String uri = domain + 'lk/index.php?route=claims/claims/api_sendMessage';
    try {
      var formData;
      if (file == null) {
        formData = FormData.fromMap({
          'claim_id': claim_id,
          'text': text,
        });
      } else {
        formData = FormData.fromMap({
          'contract_files_name[]': file.path!.split('/').last, //имя файла
          'contract_files[]': await MultipartFile.fromFile(file.path!,
              filename: file.path!.split('/').last),
          'claim_id': claim_id,
          'text': text,
        });
      }
      final result = await _apiClient.post(uri, data: formData);
      if (result.statusCode == 200) {
        return result.data;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Object?> sendBaseClaim(
      BaseClaimSendService baseClaimSendService) async {
    String uri = domain + 'lk/index.php?route=claims/new_claim/api_sendClaim';
    List<MultipartFile> files = [];
    List<String> fileNames = [];

    var entries = baseClaimSendService.files!.entries.toList();
    for (int i = 0; i < baseClaimSendService.files!.length; i++) {
      if (entries[i].value != null) {
        dynamic file = File(entries[i].value!.files[0].path!);
        MultipartFile multipartFile = await MultipartFile.fromFile(
          file.path!,
          filename: file.path!.split('/').last,
        );
        fileNames.add(file.path!.split('/').last);
        files.add(multipartFile);
      }
    }
    try {
      var formdata = FormData.fromMap({
        'claim_type_id': baseClaimSendService.claim_type_id,
        'claim_name': baseClaimSendService.claim_name,
        'field_header_whom_1': baseClaimSendService.field_header_whom_1,
        'field_phone': baseClaimSendService.field_phone,
        'field_email': baseClaimSendService.field_email,
        'field_content_date': baseClaimSendService.field_content_date,
        'claim_type': baseClaimSendService.claim_type,
        'claim_template': baseClaimSendService.claim_template,
        'field_header_who': baseClaimSendService.field_header_who,
        'field_header_egrul': baseClaimSendService.field_header_egrul,
        'field_header_address_1': baseClaimSendService.field_header_address_1,
        'field_header_address_2': baseClaimSendService.field_header_address_2,
        'field_header_egrul_date': baseClaimSendService.field_header_egrul_date,
        'field_content_main': baseClaimSendService.field_content_main,
        'isMobile': '1',
        'contract_files[]': files,
        'contract_files_name[]': fileNames
      });

      final result = await _apiClient.post(uri, data: formdata);
      if (result.statusCode == 200) {
        return result.data['data'];
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Object?> sendMainClaim(
      MainClaimSendService mainClaimSendService) async {
    String uri = domain + 'lk/index.php?route=claims/new_claim/api_sendClaim';
    List<MultipartFile> files = [];
    List<String> fileNames = [];

    var entries = mainClaimSendService.files!.entries.toList();
    for (int i = 0; i < mainClaimSendService.files!.length; i++) {
      if (entries[i].value != null) {
        dynamic file = File(entries[i].value!.files[0].path!);
        MultipartFile multipartFile = await MultipartFile.fromFile(
          file.path!,
          filename: file.path!.split('/').last,
        );
        fileNames.add(file.path!.split('/').last);
        files.add(multipartFile);
      }
    }
    Map<String, dynamic> objectsMap = Map<String, dynamic>();
    for (int i = 0; i < mainClaimSendService.step2Object!.length; i++) {
      var object = {
        'table_object[${i + 1}][0]': mainClaimSendService.step2Object![i]!.name,
        'table_object[${i + 1}][1]':
            mainClaimSendService.step2Object![i]!.address,
        'table_object[${i + 1}][2]':
            mainClaimSendService.step2Object![i]!.kadastr
      };
      objectsMap.addEntries(object.entries);
    }
    Map<String, dynamic> stagesMap = Map<String, dynamic>();
    for (int i = 0; i < mainClaimSendService.step5Stage!.length; i++) {
      var object = {
        'table_staging[${i + 1}][0]': mainClaimSendService.step5Stage![i].stage,
        'table_staging[${i + 1}][1]':
            mainClaimSendService.step5Stage![i].projectTerm,
        'table_staging[${i + 1}][2]':
            mainClaimSendService.step5Stage![i].inputTerm,
        'table_staging[${i + 1}][3]': mainClaimSendService.step5Stage![i].power,
        'table_staging[${i + 1}][4]':
            mainClaimSendService.step5Stage![i].category,
      };
      stagesMap.addEntries(object.entries);
    }
    Map<String, dynamic> formDataMap = <String, dynamic>{
      'claim_type_id': mainClaimSendService.claim_type_id,
      'claim_name': mainClaimSendService.claim_name,
      'field_header_whom_1': mainClaimSendService.field_header_whom_1,
      'field_phone': mainClaimSendService.field_phone,
      'field_email': "info@conres.ru",
      'field_content_date': mainClaimSendService.field_header_egrul_date,
      'claim_type': mainClaimSendService.claim_type,
      'claim_template': mainClaimSendService.claim_template,
      'field_header_who': mainClaimSendService.field_header_who,
      'field_header_egrul': mainClaimSendService.field_header_egrul,
      'field_header_address_1': mainClaimSendService.field_header_address_1,
      'field_header_address_2': mainClaimSendService.field_header_address_2,
      'field_header_egrul_date': mainClaimSendService.field_header_egrul_date,
      'reason': mainClaimSendService.reason,
      'table_object[0][0]': "Наименование объекта",
      'table_object[0][1]': "Адрес объекта",
      'table_object[0][2]': "Кадастровый номер (необязательно)",
      'table_staging[0][0]': 'Этап (очередь) строительства',
      'table_staging[0][1]':
          'Планируемый срок проектирования энергоприниюмающих устройств (месяц, год)',
      'table_staging[0][2]':
          'Планируемый срок введения энергопринимающих устройств в эксплуатацию(месяц, год)',
      'table_staging[0][3]':
          'Максимальная мощность энергопринимаю-щих устройств (кВт)',
      'table_staging[0][4]':
          'Категория надежности энергопринимаю-щих устройств',
      'field_max_power_3': mainClaimSendService.field_max_power_3,
      'field_max_voltage_3': mainClaimSendService.field_max_voltage_3,
      'field_max_connect_power_3':
          mainClaimSendService.field_max_connect_power_3,
      'field_max_connect_voltage_3':
          mainClaimSendService.field_max_connect_voltage_3,
      'field_max_current_power_3':
          mainClaimSendService.field_max_current_power_3,
      'field_max_current_voltage_3':
          mainClaimSendService.field_max_current_voltage_3,
      'field_max_power_2': mainClaimSendService.field_max_power_2,
      'field_max_voltage_2': mainClaimSendService.field_max_voltage_2,
      'field_max_connect_power_2':
          mainClaimSendService.field_max_connect_power_2,
      'field_max_connect_voltage_2':
          mainClaimSendService.field_max_connect_voltage_2,
      'field_max_current_power_2':
          mainClaimSendService.field_max_current_power_2,
      'field_max_current_voltage_2':
          mainClaimSendService.field_max_current_voltage_2,
      'field_max_power_1': mainClaimSendService.field_max_power_1,
      'field_max_voltage_1': mainClaimSendService.field_max_voltage_1,
      'field_max_connect_power_1':
          mainClaimSendService.field_max_connect_power_1,
      'field_max_connect_voltage_1':
          mainClaimSendService.field_max_connect_voltage_1,
      'field_max_current_power_1':
          mainClaimSendService.field_max_current_power_1,
      'field_max_current_voltage_1':
          mainClaimSendService.field_max_current_voltage_1,
      'field_load_nature': mainClaimSendService.field_load_nature,
      'field_tech_min': mainClaimSendService.field_tech_min,
      'field_emergency_armor_needed':
          mainClaimSendService.field_emergency_armor_needed,
      'field_emergency_armor_count':
          mainClaimSendService.field_emergency_armor_count,
      'field_count_power_transformer':
          mainClaimSendService.field_count_power_transformer,
      'field_count_power_generator':
          mainClaimSendService.field_count_power_generator,
      'field_gp': mainClaimSendService.field_gp,
      'field_contract_type': mainClaimSendService.field_contract_type,
      'contract_files[]': files,
      'contract_files_name[]': fileNames
    };
    formDataMap.addEntries(objectsMap.entries);
    formDataMap.addEntries(stagesMap.entries);
    try {
      var formdata = FormData.fromMap(formDataMap);

      final result = await _apiClient.post(uri, data: formdata);
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Object?> editObjectPu(
      String object_id, String object_name, String object_address) async {
    String uri =
        domain + 'lk/index.php?route=catalog/objects/api_editObjectsInfo';
    var formdata = FormData.fromMap({
      'object_id': object_id,
      'new_object_name': object_name,
      'new_object_address': object_address
    });
    final result = await _apiClient.post(uri, data: formdata);
    if (result.statusCode == 200) {
      return result.data['data']['edit'];
    } else {
      return false;
    }
  }

  Future<Object?> editObjectTu(String point_id, String new_tu_number,
      String new_tu_name, String new_tu_address) async {
    String uri = domain + 'lk/index.php?route=catalog/pu_info/api_editTuInfo';
    var formdata = FormData.fromMap({
      'point_id': point_id,
      'new_tu_number': new_tu_number,
      'new_tu_name': new_tu_name,
      'new_tu_address': new_tu_address
    });
    final result = await _apiClient.post(uri, data: formdata);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
