import 'package:conres_app/model/result-data.dart';
import 'package:conres_app/model/ticket.dart';

import '../../model/claim.dart';
import '../../model/contract.dart';
import '../../model/message.dart';
import '../../websocket/websocket.dart';

class ProfileState {
  final String? cookieStr;
  final bool? loading;
  final String? error;
  final List<dynamic>? loginData;
  final List<Contract>? contracts;
  final List<String>? numbers;
  final List<Claim>? claims;
  final List<Ticket>? tickets;
  final List<TicketMessage>? messages;
  final dynamic webSocketData;
  final ResultData? bindLsData;
  final Map<String, dynamic>? sendMessageData;
  final String? page;

  ProfileState(
      {this.loginData,
      this.cookieStr,
      this.loading,
      this.error,
      this.webSocketData,
      this.bindLsData,
      this.contracts,
      this.numbers,
      this.claims,
      this.tickets,
      this.messages,
      this.sendMessageData,
      this.page});

  static initial() => ProfileState(cookieStr: null, loading: null, error: null);
  static clear() => ProfileState(loading: false, sendMessageData: null, error: null);
  ProfileState copyWith(
      {String? cookieStr,
      bool? loading,
      List<dynamic>? loginData,
      ResultData? bindLsData,
      Map<String, dynamic>? sendMessageData,
      dynamic webSocketData, 
      List<Contract>? contracts,
      List<String>? numbers,
      String? error,
      List<Claim>? claims,
      List<Ticket>? tickets,
      List<TicketMessage>? messages,
      String? page}) {
    return ProfileState(
        error: error,
        loading: loading ?? this.loading,
        cookieStr: cookieStr ?? this.cookieStr,
        loginData: loginData ?? this.loginData,
        bindLsData: bindLsData ?? this.bindLsData,
        contracts: contracts ?? this.contracts,
        numbers: numbers ?? this.numbers,
        claims: claims ?? this.claims,
        tickets: tickets ?? this.tickets,
        messages: messages,
        sendMessageData: sendMessageData,
        webSocketData: webSocketData,
        page: page ?? this.page);
  }
}
