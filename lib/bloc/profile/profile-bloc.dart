import 'package:bloc/bloc.dart';
import 'package:conres_app/bloc/profile/profile-event.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/claims/claims.dart';
import 'package:conres_app/model/contract.dart';
import 'package:conres_app/model/message.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/claim.dart';
import '../../model/ticket.dart';
import '../../repositories/profile-repo.dart';
import '../../shared-preferences/shared-preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  final ProfileRepo repo;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if(event is GetCookieStrEvent){
      yield* _handleGetCookies(event);
    }
    if(event is GetLoginData){
      yield* _handleGetData(event);
    }
    if(event is GetWebSocketData){
      yield* _handleGetWebSocketData(event);
    }
    if(event is LogoutEvent){
      yield* _handleLogout(event);
    }
    if(event is BindNewLS){
      yield* _handleBindNewLS(event);
    }
    if(event is GetContracts){
      yield* _handleGetContracts(event);
    }
    if(event is GetClaims){
      yield* _handleGetClaims(event);
    }
    if(event is GetTickets){
      yield* _handleGetTickets(event);
    }
    if(event is GetMessages){
      yield* _handleGetMessages(event);
    }
    if(event is GetAllInfo){
      yield* _handleGetAllInfo(event);
    }
    if(event is SendMessageEvent){
      yield* _handleSendMessage(event);
    }

  }

  ProfileBloc(this.repo) : super(ProfileState.initial());

  getCookies(String username, String password, int type){
    add(GetCookieStrEvent(username, password, type));
  }

  getLoginData(){
    add(const GetLoginData());
  }

  getWebSocketData(){
    add(const GetWebSocketData());
  }

  logout(){
    add(const LogoutEvent());
  }

  bindNewLS(String number, String address){
    add(BindNewLS(number, address));
  }

  getContracts(){
    add(const GetContracts());
  }

  getClaims(){
    add(const GetClaims());
  }

  getTickets(){
    add(const GetTickets());
  }

  getMessages(String chat_id, String page, String last_message_id){
    add(GetMessages(chat_id, page, last_message_id));
  }

  getAllInfo(){
    add(const GetAllInfo());
  }

  sendMessage(String ticket_id, String message, String ticket_status_id){
    add(SendMessageEvent(ticket_id, message, ticket_status_id));
  }

  Stream<ProfileState> _handleGetCookies(GetCookieStrEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      String result = await repo.getCookie(event.username, event.password, event.type);
      yield state.copyWith(loading: false, error: result, cookieStr: result);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
  Stream<ProfileState> _handleGetData(GetLoginData event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.loginData();
      if(result is List<dynamic>){
        yield state.copyWith(loading: false, error: null, loginData: result);
      }
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
  Stream<ProfileState> _handleGetWebSocketData(GetWebSocketData event) async*{
    yield state.copyWith(loading: true, error: null);
    try{

    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
  Stream<ProfileState> _handleLogout(LogoutEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await logoutFunc(preferences);
      List<dynamic> emptyLoginData = [];
      yield state.copyWith(loginData: emptyLoginData, error: null, loading: false);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }

  }

  Stream<ProfileState> _handleBindNewLS(BindNewLS event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.bindLs(event.number, event.address);
      if(result is ResultData){
        yield state.copyWith(loading: false, error: null, bindLsData: result);
      }
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetContracts(GetContracts event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.getContracts();
      if(result is List<Contract>){
        yield state.copyWith(loading: false, error: null, contracts: result);
      }
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
  Stream<ProfileState> _handleGetClaims(GetClaims event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.getClaims();
      if(result is List<Claim>){
        yield state.copyWith(loading: false, error: null, claims: result);
      }
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetTickets(GetTickets event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.getTickets();
      if(result is List<Ticket>){
        yield state.copyWith(loading: false, tickets: result);
      }
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetMessages(GetMessages event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.getMessageFromTicket(event.chat_id, event.page, event.last_message_id);
      if(result is List<TicketMessage>){
        yield state.copyWith(loading: false, error: null, messages: result);
      }
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleGetAllInfo(GetAllInfo event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.getAllInfo();
      if(result is ResultData){
        yield state.copyWith(loading: false, bindLsData: result);
      }
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }

  Stream<ProfileState> _handleSendMessage(SendMessageEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.sendMessage(event.ticket_id, event.message, event.ticket_status_id);
      if(result is Map<String, dynamic>){
        yield state.copyWith(loading: false, sendMessageData: result);
        yield state.copyWith(messages: null);
      }
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
}