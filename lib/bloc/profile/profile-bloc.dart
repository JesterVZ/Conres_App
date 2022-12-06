import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:conres_app/Services/main-claim-send-service.dart';
import 'package:conres_app/bloc/profile/profile-event.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/claims/claims.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/model/claim-message.dart';
import 'package:conres_app/model/contract.dart';
import 'package:conres_app/model/message.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:conres_app/model/user-information.dart';
import 'package:conres_app/websocket/websocket.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../DI/dependency-provider.dart';
import '../../Services/base-claim-send-service.dart';
import '../../Services/profile-service.dart';
import '../../model/claim.dart';
import '../../model/counter.dart';
import '../../model/ticket.dart';
import '../../repositories/profile-repo.dart';
import '../../shared-preferences/shared-preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo repo;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is SetCounters) {
      yield* _handleSetCounters(event);
    } else if (event is GetCookieStrEvent) {
      yield* _handleGetCookies(event);
    } else if (event is GetLoginData) {
      yield* _handleGetData(event);
    } else if (event is GetWebSocketData) {
      yield* _handleGetWebSocketData(event);
    } else if (event is LogoutEvent) {
      yield* _handleLogout(event);
    } else if (event is BindNewLS) {
      yield* _handleBindNewLS(event);
    } else if (event is HiddenAccountRequest) {
      yield* _handleHideAccount(event);
    } else if (event is GetContracts) {
      yield* _handleGetContracts(event);
    } else if (event is GetClaims) {
      yield* _handleGetClaims(event);
    } else if (event is GetTickets) {
      yield* _handleGetTickets(event);
    } else if (event is GetMessages) {
      yield* _handleGetMessages(event);
    } else if (event is GetAllInfo) {
      yield* _handleGetAllInfo(event);
    } else if (event is SendMessageEvent) {
      yield* _handleSendMessage(event);
    } else if (event is EditMessageEvent) {
      yield* _handleEditMessage(event);
    } else if (event is SendClaimMessageEvent) {
      yield* _handleSendClaimMessage(event);
    } else if (event is ReadMessage) {
      yield* _handleReadMessage(event);
    } else if (event is ReadClaimMessage) {
      yield* _handleReadClaimMessage(event);
    } else if (event is DownloadFile) {
      yield* _handleDownloadFile(event);
    } else if (event is GetFullProfileInfo) {
      yield* _handleGetFullProfileInfo(event);
    } else if (event is GetObjectsPU) {
      yield* _handleGetObjectsPU(event);
    } else if (event is GetTU) {
      yield* _handleGetTU(event);
    } else if (event is CreateNewTicket) {
      yield* _handleCreateNewTicket(event);
    } else if (event is GetClaimMessages) {
      yield* _handleGetClaimMessages(event);
    } else if (event is GetAllPhotos) {
      yield* _handleGetAllPhotos(event);
    } else if (event is SendBaseClaim) {
      yield* _handleSendBaseClaim(event);
    } else if (event is GetTuPoints) {
      yield* _handleGetTuPoints(event);
    } else if (event is GetPrivatePolicy) {
      yield* _handleGetPrivatePolicy(event);
    } else if (event is SendTestimonyEvent) {
      yield* _handleSendTestimony(event);
    } else if (event is SendMainClaim) {
      yield* _handleSendMainClaim(event);
    } else if (event is EditObject) {
      yield* _handleEditObject(event);
    } else if (event is EditTu) {
      yield* _handleEditTu(event);
    } else if(event is HiddenObjectRequest){
      yield* _handleHideObject(event);
    } else if(event is BindNewObject){
      yield* _handleBindNewObject(event);
    } else if(event is BindNewTU){
      yield* _handleBindTU(event);
    } else if(event is HidenTuRequest){
      yield* _handleHideTu(event);
    } else if(event is GetMetersFromTU){
      yield* _handleGetMetersFromTU(event);
    }
  }

  ProfileBloc(this.repo) : super(ProfileState.initial());

  getCookies(List cookies) {
    add(GetCookieStrEvent(cookies));
  }

  getLoginData() {
    add(const GetLoginData());
  }

  getWebSocketData(WebSocketData webSocketData) {
    add(GetWebSocketData(webSocketData));
  }

  logout() {
    add(const LogoutEvent());
  }

  bindNewLS(String number, String address) {
    add(BindNewLS(number, address));
  }

  getContracts() {
    add(const GetContracts());
  }

  getClaims() {
    add(const GetClaims());
  }

  getTickets(String page) {
    add(GetTickets(page));
  }

  getMessages(String chat_id, String page, String last_message_id) {
    add(GetMessages(chat_id, page, last_message_id));
  }

  getClaimMessages(String claim_id) {
    add(GetClaimMessages(claim_id));
  }

  getAllInfo() {
    add(const GetAllInfo());
  }

  sendMessage(
      String ticket_id, String message, String ticket_status_id, dynamic file) {
    add(SendMessageEvent(ticket_id, message, ticket_status_id, file));
  }

  sendClaimMessage(String claim_id, String text, dynamic file) {
    add(SendClaimMessageEvent(claim_id, text, file));
  }

  readMessage(String ticketId, String messageId) {
    add(ReadMessage(ticketId, messageId));
  }

  readClaimMessage(String claimId, String messageId) {
    add(ReadClaimMessage(claimId, messageId));
  }

  downloadFile(String uri, String filename) {
    add(DownloadFile(uri, filename));
  }

  getObjectsPU() {
    add(const GetObjectsPU());
  }

  getFullProfileInfo() {
    add(const GetFullProfileInfo());
  }

  getTU() {
    add(const GetTU());
  }

  getTuPoints() {
    add(const GetTuPoints());
  }

  createNewTicket(String contact_email, String contact_name,
      String ticket_theme_id, String message) {
    add(CreateNewTicket(contact_email, contact_name, message, ticket_theme_id));
  }

  getAllPhotos(Album album) {
    add(GetAllPhotos(album));
  }

  editMessage(
      String ticket_id, String message, String ticket_status_id, dynamic file) {
    add(EditMessageEvent(ticket_id, message, ticket_status_id, file));
  }

  sendBaseClaim(BaseClaimSendService baseClaimSendService) {
    add(SendBaseClaim(baseClaimSendService));
  }

  sendMainClaim(MainClaimSendService mainClaimSendService) {
    add(SendMainClaim(mainClaimSendService));
  }

  getPrivatePolicy() {
    add(GetPrivatePolicy());
  }

  sendTestimony(List<String> dayValues, List<String> nightValues) {
    add(SendTestimonyEvent(dayValues, nightValues));
  }

  setCounters(int ticketCounter, int claimCounter) {
    add(SetCounters(ticketCounter, claimCounter));
  }

  editObject(String id, String name, String address) {
    add(EditObject(id, name, address));
  }

  editTu(String id, String number, String name, String address) {
    add(EditTu(id, number, name, address));
  }

  hiddenAccout(String account_id) {
    add(HiddenAccountRequest(account_id));
  }

  hiddenObject(String object_id){
    add(HiddenObjectRequest(object_id));
  }

  hiddenTU(String point_id){
    add(HidenTuRequest(point_id));
  }

  bindNewObject(String objectName, String objectAddress){
    add(BindNewObject(objectName, objectAddress));
  }

  bindNewTU(String object_id, String new_tu_number, String new_tu_name, String new_tu_address){
    add(BindNewTU(object_id, new_tu_number, new_tu_name, new_tu_address));
  }

  getMetersFromTU(String point_id){
    add(GetMetersFromTU(point_id));
  }

  Stream<ProfileState> _handleGetCookies(GetCookieStrEvent event) async* {
    //получение строки из cookie (нужно для отправки в сокет)
    yield state.copyWith(loading: true, error: null);
    try {
      String result = await repo.getCookie(event.cookies);
      yield state.copyWith(loading: false, error: result, cookieStr: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetData(GetLoginData event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object result = await repo.loginData();
      if (result is List<dynamic>) {
        yield state.copyWith(loading: false, error: null, loginData: result);
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetWebSocketData(GetWebSocketData event) async* {
    yield state.copyWith(loading: true, error: null);
    try {} catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleLogout(LogoutEvent event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await logoutFunc(preferences);
      yield state.clear();
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleBindNewLS(BindNewLS event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Map<String, dynamic> result =
          await repo.bindLs(event.number, event.address);
      yield state.copyWith(loading: false, error: null, bindLsData: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetContracts(GetContracts event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object result = await repo.getContracts();
      if (result is List<Contract>) {
        yield state.copyWith(loading: false, error: null, contracts: result);
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetClaims(GetClaims event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object result = await repo.getClaims();
      if (result is List<Claim>) {
        yield state.copyWith(loading: false, error: null, claims: result);
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetTickets(GetTickets event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object result = await repo.getTickets(event.page);
      if (result is List<Ticket>) {
        yield state.copyWith(loading: false, tickets: result, page: event.page);
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetMessages(GetMessages event) async* {
    yield state.copyWith(loading: true, error: null, ticketFullInfo: null);
    try {
      Object result = await repo.getMessageFromTicket(
          event.chat_id, event.page, event.last_message_id);
      if (result is TicketFullInfo) {
        yield state.copyWith(
            loading: false,
            error: null,
            ticketFullInfo: result,
            page: event.page);
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetAllInfo(GetAllInfo event) async* {
    // создать переменную под result
    yield state.copyWith(loading: true, error: null);
    try {
      Object result = await repo.getAllInfo();
      if (result is Map<String, dynamic>) {
        user_id = result['user_id'];
        yield state.copyWith(
          loading: false,
          fullInfo: result,
        );
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleSendMessage(SendMessageEvent event) async* {
    yield state.copyWith(loading: true, error: null, ticketFullInfo: null);
    try {
      Object result = await repo.sendMessage(
          event.ticket_id, event.message, event.ticket_status_id, event.file);
      if (result is Map<String, dynamic>) {
        yield state.copyWith(
            loading: false, sendMessageData: result, ticketFullInfo: null);
      } else {
        yield state.copyWith(
            loading: false,
            sendMessageData: null,
            ticketFullInfo: null,
            error: result.toString());
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleEditMessage(EditMessageEvent event) async* {
    yield state.copyWith(loading: true, error: null, ticketFullInfo: null);
    try {
      Object result = await repo.editMessage(
          event.ticket_id, event.message, event.ticket_status_id, event.file);
      if (result is Map<String, dynamic>) {
        yield state.clear();
      } else {
        yield state.copyWith(
            loading: false,
            sendMessageData: null,
            ticketFullInfo: null,
            error: result.toString());
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleSendClaimMessage(
      SendClaimMessageEvent event) async* {
    yield state.copyWith(loading: true, error: null, ticketFullInfo: null);
    try {
      Object result =
          await repo.sendClaimMessage(event.claim_id, event.text, event.file);
      if (result is Map<String, dynamic>) {
        yield state.copyWith(
            loading: false, sendMessageData: result, ticketFullInfo: null);
      } else {
        yield state.copyWith(
            loading: false,
            sendMessageData: null,
            ticketFullInfo: null,
            error: result.toString());
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleReadMessage(ReadMessage event) async* {
    yield state.copyWith(loading: false, error: null, ticketFullInfo: null);
    try {
      await repo.readMessage(event.ticketId, event.messageId);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleReadClaimMessage(ReadClaimMessage event) async* {
    yield state.copyWith(loading: false, error: null, ticketFullInfo: null);
    try {
      await repo.readClaimMessage(event.claimId, event.messageId);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleDownloadFile(DownloadFile event) async* {
    yield state.copyWith(loading: true, error: null, ticketFullInfo: null);
    try {
      var result = await repo.downloadFie(event.uri, event.filename);
      yield state.copyWith(loading: false, error: null, ticketFullInfo: null);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetFullProfileInfo(
      GetFullProfileInfo event) async* {
    yield state.copyWith(loading: true, error: null, ticketFullInfo: null);
    try {
      var result = await repo.getFullProfileInfo();
      if (result is UserInformation) {
        yield state.copyWith(
            loading: false, error: null, userInformation: result);
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetObjectsPU(GetObjectsPU event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.getObjectsPU();
      yield state.copyWith(loading: false, error: null, objectsPU: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetTuPoints(GetTuPoints event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.getTU();
      yield state.copyWith(loading: false, error: null, TuPoints: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetTU(GetTU event) async* {
    // получить счетчики
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.getMeters();
      yield state.copyWith(loading: false, error: null, meters: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleCreateNewTicket(CreateNewTicket event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.createNewTicket(event.contact_email,
          event.contact_name, event.ticket_theme_id, event.message);

      yield state.copyWith(
          loading: false, error: null, createTicketData: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetClaimMessages(GetClaimMessages event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.getClaimMessages(event.claim_id);
      if (result is List<ClaimMessage>) {
        yield state.copyWith(
            loading: false, error: null, claimMessages: result);
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetAllPhotos(GetAllPhotos event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      List<Medium> imagePage = [];
      MediaPage thisAlbumImages = await event.album.listMedia();
      imagePage += thisAlbumImages.items;
      yield state.copyWith(loading: false, error: null, images: imagePage);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleSendBaseClaim(SendBaseClaim event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.sendBaseClaim(event.baseClaimSendService);
      yield state.copyWith(
          loading: false, error: null, createClaimData: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetPrivatePolicy(GetPrivatePolicy event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.getPrivatePolicy();
      yield state.copyWith(
          loading: false, error: null, privatePolicyString: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleSendTestimony(SendTestimonyEvent event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.sendTestimony(event.dayValues, event.nightValues);
      yield state.copyWith(loading: false, error: null, isMeasureSent: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleSendMainClaim(SendMainClaim event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.sendMainClaim(event.mainClaimSendService);
      yield state.copyWith(
          loading: false, error: null, createClaimData: result);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleSetCounters(SetCounters event) async* {
    try {
      yield state.copyWith(
          loading: false,
          error: null,
          ticketCounter: event.ticketCounter,
          claimCounter: event.claimCounter);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleEditObject(EditObject event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.editObject(event.id, event.name, event.address);
      yield state.copyWith(loading: false, error: null);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleEditTu(EditTu event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      var result = await repo.editObject(event.id, event.name, event.address);
      yield state.copyWith(loading: false, error: null);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleHideAccount(HiddenAccountRequest event) async* {
    var result = await repo.hideAccount(event.account_id);
  }

  Stream<ProfileState> _handleHideObject(HiddenObjectRequest event) async* {
    var result = await repo.hideObject(event.object_id);
  }

  Stream<ProfileState> _handleHideTu(HidenTuRequest event) async* {
    var result = await repo.hideTu(event.point_id);
  }

  Stream<ProfileState> _handleBindNewObject(BindNewObject event) async* {
    try{
      var result = await repo.bindNewObject(event.objectName, event.objectAddress);
      yield state.copyWith(loading: false, error: null, bindObjectData: result);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
    
  }

  Stream<ProfileState> _handleBindTU(BindNewTU event) async*{
    try{
      var result = await repo.bindNewTU(event.object_id, event.new_tu_number, event.new_tu_name, event.new_tu_address);
      yield state.copyWith(loading: false, error: null, bindTuData: result);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetMetersFromTU(GetMetersFromTU event) async*{
    try{
      yield state.copyWith(loading: true, error: null);
      var result = await repo.getMetersFromTu(event.point_id);
      yield state.copyWith(loading: false, error: null, TuMeters: result);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
}
