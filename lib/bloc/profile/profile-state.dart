import 'package:conres_app/model/claim-message.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:conres_app/model/ticket.dart';

import '../../elements/testimony/object-pu.dart';
import '../../model/claim.dart';
import '../../model/contract.dart';
import '../../model/counter.dart';
import '../../model/message.dart';
import '../../model/meter.dart';
import '../../model/user-information.dart';
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
  final List<ObjectPuModel>? objectsPU;
  final List<Meter>? meters;
  final List<ClaimMessage>? claimMessages;
  final TicketFullInfo? ticketFullInfo;
  final dynamic webSocketData;
  final ResultData? bindLsData;
  final Map<String, dynamic>? sendMessageData;
  final String? page;
  final UserInformation? userInformation;

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
      this.ticketFullInfo,
      this.sendMessageData,
      this.page,
      this.meters,
      this.claimMessages,
      this.objectsPU,
      this.userInformation});

  static initial() => ProfileState(cookieStr: null, loading: null, error: null);
  ProfileState copyWith(
      {String? cookieStr,
      bool? loading,
      List<dynamic>? loginData,
      ResultData? bindLsData,
      Map<String, dynamic>? sendMessageData,
      dynamic webSocketData, 
      List<Contract>? contracts,
      List<String>? numbers,
      List<ObjectPuModel>? objectsPU,
      String? error,
      List<Claim>? claims,
      List<Ticket>? tickets,
      List<ClaimMessage>? claimMessages,
      TicketFullInfo? ticketFullInfo,
      List<Meter>? meters,
      String? page,
      UserInformation? userInformation}) {
    return ProfileState(
        error: error,
        loading: loading ?? this.loading,
        cookieStr: cookieStr ?? this.cookieStr,
        loginData: loginData,
        bindLsData: bindLsData ?? this.bindLsData,
        contracts: contracts ?? this.contracts,
        numbers: numbers ?? this.numbers,
        claims: claims ?? this.claims,
        tickets: tickets ?? this.tickets,
        claimMessages: claimMessages ?? this.claimMessages,
        ticketFullInfo: ticketFullInfo,
        sendMessageData: sendMessageData,
        webSocketData: webSocketData,
        objectsPU: objectsPU,
        meters: meters,
        userInformation: userInformation,
        page: page ?? this.page);
  }
}
