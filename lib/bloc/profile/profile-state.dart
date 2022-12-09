import 'package:conres_app/model/TU.dart';
import 'package:conres_app/model/claim-message.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:conres_app/model/ticket.dart';
import 'package:photo_gallery/photo_gallery.dart';

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
  final bool? isMeasureSent;
  final String? error;
  final Map<String, dynamic>? fullInfo;

  final int? ticketCounter;
  final int? claimCounter;

  final List<dynamic>? loginData;
  final List<Contract>? contracts;
  final List<String>? numbers;
  final List<Claim>? claims;
  final List<Ticket>? tickets;
  final List<ObjectPuModel>? objectsPU;
  final List<TuModel>? TuPoints;
  final List<Meter>? meters;
  final List<Meter>? TuMeters;

  final List<ClaimMessage>? claimMessages;
  final List<Medium>? images;

  final TicketFullInfo? ticketFullInfo;
  final dynamic webSocketData;
  final Map<String, dynamic>? bindLsData;
  final Map<String, dynamic>? bindObjectData;
  final Map<String, dynamic>? bindTuData;
  final Map<String, dynamic>? sendMessageData;
  final Map<String, dynamic>? createTicketData;
  final Map<String, dynamic>? createClaimData;
  final Map<String, dynamic>? editObjectData;
  final Map<String, dynamic>? editTuData;
  final Map<String, dynamic>? editPuFromTuData;
  final Map<String, dynamic>? bindPuData;

  final String? page;
  final UserInformation? userInformation;

  final bool? isClaimSent;

  final String? privatePolicyString;

  ProfileState(
      {this.loginData,
      this.cookieStr,
      this.loading,
      this.error,
      this.webSocketData,
      this.bindLsData,
      this.bindObjectData,
      this.bindTuData,
      this.fullInfo,
      this.contracts,
      this.numbers,
      this.claims,
      this.bindPuData,
      this.editTuData,
      this.editPuFromTuData,
      this.images,
      this.tickets,
      this.ticketFullInfo,
      this.sendMessageData,
      this.editObjectData,
      this.page,
      this.meters,
      this.TuMeters,
      this.claimMessages,
      this.objectsPU,
      this.ticketCounter,
      this.claimCounter,
      this.createTicketData,
      this.createClaimData,
      this.TuPoints,
      this.privatePolicyString,
      this.isMeasureSent,
      this.isClaimSent,
      this.userInformation});

  static initial() => ProfileState(cookieStr: null, loading: null, error: null);
  ProfileState clear() => ProfileState(
      cookieStr: null,
      loading: false,
      error: null,
      TuPoints: null,
      bindLsData: null,
      bindObjectData: null,
      bindTuData: null,
      claimCounter: null,
      claimMessages: null,
      bindPuData: null,
      claims: null,
      contracts: null,
      createClaimData: null,
      createTicketData: null,
      fullInfo: null,
      editObjectData: null,
      editPuFromTuData: null,
      images: null,
      editTuData: null,
      isClaimSent: null,
      isMeasureSent: null,
      loginData: [],
      meters: null,
      TuMeters: null,
      numbers: null,
      objectsPU: null,
      page: null,
      privatePolicyString: null,
      sendMessageData: null,
      ticketCounter: null,
      ticketFullInfo: null,
      tickets: null,
      userInformation: null,
      webSocketData: null);

  ProfileState copyWith(
      {String? cookieStr,
      bool? loading,
      bool? isMeasureSent,
      List<dynamic>? loginData,
      Map<String, dynamic>? bindLsData,
      Map<String, dynamic>? bindObjectData,
      Map<String, dynamic>? sendMessageData,
      Map<String, dynamic>? bindTuData,
      Map<String, dynamic>? editObjectData,
      Map<String, dynamic>? editTuData,
      Map<String, dynamic>? editPuFromTuData,
      Map<String, dynamic>? bindPuData,
      dynamic webSocketData,
      List<Contract>? contracts,
      List<String>? numbers,
      List<ObjectPuModel>? objectsPU,
      String? error,
      Map<String, dynamic>? fullInfo,
      List<TuModel>? TuPoints,
      int? ticketCounter,
      int? claimCounter,
      String? privatePolicyString,
      List<Claim>? claims,
      List<Ticket>? tickets,
      List<ClaimMessage>? claimMessages,
      List<Medium>? images,
      Map<String, dynamic>? createClaimData,
      TicketFullInfo? ticketFullInfo,
      Map<String, dynamic>? createTicketData,
      List<Meter>? meters,
      List<Meter>? TuMeters,
      String? page,
      bool? isClaimSent,
      UserInformation? userInformation}) {
    return ProfileState(
        error: error,
        loading: loading ?? this.loading,
        cookieStr: cookieStr ?? this.cookieStr,
        loginData: loginData,
        isMeasureSent: isMeasureSent,
        bindLsData: bindLsData,
        bindObjectData: bindObjectData,
        bindTuData: bindTuData,
        editObjectData: editObjectData,
        editTuData: editTuData,
        bindPuData: bindPuData,
        contracts: contracts ?? this.contracts,
        editPuFromTuData: editPuFromTuData,
        numbers: numbers ?? this.numbers,
        claims: claims ?? this.claims,
        tickets: tickets ?? this.tickets,
        claimMessages: claimMessages,
        images: images,
        createClaimData: createClaimData,
        createTicketData: createTicketData,
        ticketCounter: ticketCounter,
        claimCounter: claimCounter,
        privatePolicyString: privatePolicyString,
        TuPoints: TuPoints ?? this.TuPoints,
        ticketFullInfo: ticketFullInfo,
        sendMessageData: sendMessageData,
        webSocketData: webSocketData,
        fullInfo: fullInfo ?? this.fullInfo,
        objectsPU: objectsPU,
        meters: meters,
        TuMeters: TuMeters,
        userInformation: userInformation,
        isClaimSent: isClaimSent,
        page: page ?? this.page);
  }
}
