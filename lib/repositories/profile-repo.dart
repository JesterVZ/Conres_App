import 'dart:io';

import 'package:conres_app/http.dart';
import 'package:file_picker/file_picker.dart';
import '../shared-preferences/shared-preferences.dart';

class ProfileRepo{
  final HttpClient httpClient;

  ProfileRepo({required this.httpClient});

  Future<String>getCookie(List cookies) async{
    String result = await httpClient.getCookieStringForWebSocket(cookies);
    return result;
  }
  Future<dynamic> loginData() async {
    var result = await getLogin();
    if (result is List<dynamic>) {
      return result;
    }
  }
  Future<dynamic> bindLs(String number, String address) async{
    var result = await httpClient.bindNewLS(number, address);
    return result;
  }
  Future<dynamic> getContracts() async{
    var result = await httpClient.getContracts();
    return result;
  }
  Future<dynamic> getInfo() async{
    var result = await httpClient.getInfo();
    return result;
  }
  Future<dynamic> getClaims() async{
    var result = await httpClient.getClaims();
    return result;
  }
  Future<dynamic> getTickets(String page) async{
    var result = await httpClient.getTickets(page);
    return result;
  }
  Future<dynamic> getMessageFromTicket(String chat_id, String page, String last_message_id) async{
    var result = await httpClient.getMessagesFromTicket(chat_id, page, last_message_id);
    return result;
  }
  Future<dynamic> getAllInfo() async{
    var result = await httpClient.getInfo();
    return result;
  }
  Future<dynamic> sendMessage(String ticketId, String message, String ticketStatusId, dynamic file) async{
    var result = await httpClient.sendMessage(ticketId, message, ticketStatusId, file);
    return result;
  }
  Future<dynamic> sendClaimMessage(String claim_id, String text, dynamic file) async{
    var result = await httpClient.sendClaimMessage(claim_id, text, file);
    return result;
  }
  Future<dynamic> readMessage(String ticketId, String messageId) async{
    await httpClient.setReadMessage(ticketId, messageId);
  }
  Future<dynamic> downloadFie(String uri, String filename) async{
    var result = await httpClient.download(uri, filename);
    return result;
  }
  Future<dynamic> getFullProfileInfo() async{
    var result = await httpClient.getFullProfileInfo();
    return result;
  }
  Future<dynamic> getObjectsPU() async{
     var result = await httpClient.getObjectsPU();
     return result;
  }
  Future<dynamic> getMeters() async{
    var result = await httpClient.getMeters();
    return result;
  }
  Future<dynamic> createNewTicket(String contact_email, String contact_name, String ticket_theme_id, String message) async{
    var result = await httpClient.addTicket(contact_email, contact_name, ticket_theme_id, message);
  }
  Future<dynamic> getClaimMessages(String claim_id) async{
    var result = await httpClient.getMessagesFromClaim(claim_id);
    return result;
  }
  Future<dynamic> editMessage(String ticketId, String message, String ticketStatusId, dynamic file) async{
    var result = await httpClient.editMessage(ticketId, message, ticketStatusId, file);
    return result;
  }
}