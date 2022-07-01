import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:conres_app/bloc/profile/profile-event.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/claims/claims.dart';
import 'package:conres_app/model/contract.dart';
import 'package:conres_app/model/message.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:conres_app/model/user-information.dart';
import 'package:conres_app/websocket/websocket.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/claim.dart';
import '../../model/counter.dart';
import '../../model/ticket.dart';
import '../../repositories/profile-repo.dart';
import '../../shared-preferences/shared-preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo repo;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetCookieStrEvent) {
      yield* _handleGetCookies(event);
    }
    else if (event is GetLoginData) {
      yield* _handleGetData(event);
    }
    else if (event is GetWebSocketData) {
      yield* _handleGetWebSocketData(event);
    }
    else if (event is LogoutEvent) {
      yield* _handleLogout(event);
    }
    else if (event is BindNewLS) {
      yield* _handleBindNewLS(event);
    }
    else if (event is GetContracts) {
      yield* _handleGetContracts(event);
    }
    else if (event is GetClaims) {
      yield* _handleGetClaims(event);
    }
    else if (event is GetTickets) {
      yield* _handleGetTickets(event);
    }
    else if (event is GetMessages) {
      yield* _handleGetMessages(event);
    }
    else if (event is GetAllInfo) {
      yield* _handleGetAllInfo(event);
    }
    else if (event is SendMessageEvent) {
      yield* _handleSendMessage(event);
    }
    else if(event is ReadMessage){
      yield* _handleReadMessage(event);
    }
    else if(event is DownloadFile){
      yield* _handleDownloadFile(event);
    }
    else if(event is GetFullProfileInfo){
      yield* _handleGetFullProfileInfo(event);
    }
    else if(event is GetObjectsPU){
      yield* _handleGetObjectsPU(event);
    }
    else if(event is GetTU){
      yield* _handleGetTU(event);
    }
  }

  ProfileBloc(this.repo) : super(ProfileState.initial());

  getCookies(String username, String password, int type) {
    add(GetCookieStrEvent(username, password, type));
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

  getAllInfo() {
    add(const GetAllInfo());
  }

  sendMessage(String ticket_id, String message, String ticket_status_id, List<PlatformFile>? files) {
    add(SendMessageEvent(ticket_id, message, ticket_status_id, files));
  }

  readMessage(String ticketId, String messageId){
    add(ReadMessage(ticketId, messageId));
  }

  downloadFile(String uri, String filename){
    add(DownloadFile(uri, filename));
  }

  getObjectsPU(){
    add(const GetObjectsPU());
  }

  getFullProfileInfo(){
    add(const GetFullProfileInfo());
  }

  getTU(){
    add(const GetTU());
  }

  Stream<ProfileState> _handleGetCookies(GetCookieStrEvent event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      String result =
          await repo.getCookie(event.username, event.password, event.type);
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
      List<dynamic> emptyLoginData = [];
      yield state.copyWith(loading: false, loginData: emptyLoginData, error: null);
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleBindNewLS(BindNewLS event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object result = await repo.bindLs(event.number, event.address);
      if (result is ResultData) {
        yield state.copyWith(loading: false, error: null, bindLsData: result);
      }
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
    yield state.copyWith(loading: true, error: null);
    try {
      Object result = await repo.getAllInfo();
      if (result is ResultData) {
        yield state.copyWith(loading: false, bindLsData: result);
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleSendMessage(SendMessageEvent event) async* {
    yield state.copyWith(loading: true, error: null, ticketFullInfo: null);
    try {
      Object result = await repo.sendMessage(
          event.ticket_id, event.message, event.ticket_status_id, event.files);
      if (result is Map<String, dynamic>) {
        yield state.copyWith(
            loading: false, sendMessageData: result, ticketFullInfo: null);
      } else {
        yield state.copyWith(
            loading: false, sendMessageData: null, ticketFullInfo: null, error: result.toString());
      }
    } catch (e) {
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleReadMessage(ReadMessage event) async*{
    yield state.copyWith(loading: false, error: null, ticketFullInfo: null);
    try{
      await repo.readMessage(event.ticketId, event.messageId);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleDownloadFile(DownloadFile event) async*{
    yield state.copyWith(loading: true, error: null, ticketFullInfo: null);
    try{
      var result = await repo.downloadFie(event.uri, event.filename);
      yield state.copyWith(loading: false, error: null, ticketFullInfo: null);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetFullProfileInfo(GetFullProfileInfo event) async*{
    yield state.copyWith(loading: true, error: null, ticketFullInfo: null);
    try{
      var result = await repo.getFullProfileInfo();
      if(result is UserInformation){
        yield state.copyWith(loading: false, error: null, userInformation: result);
      }
      
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetObjectsPU(GetObjectsPU event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      var result = await repo.getObjectsPU();
      yield state.copyWith(loading: false, error: null, objectsPU: result);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetTU(GetTU event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      var result = await repo.getMeters();
      yield state.copyWith(loading: false, error:null, meters: result);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

}
