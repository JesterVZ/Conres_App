import 'package:bloc/bloc.dart';
import 'package:conres_app/bloc/profile/profile-event.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/model/contract.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    if(event is GetNumbers){
      yield* _handleGetNumbers(event);
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

  getNumbers(){
    add(const GetNumbers());
  }

  Stream<ProfileState> _handleGetCookies(GetCookieStrEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      String result = await repo.getCookie(event.username, event.password, event.type);
      yield state.copyWith(loading: false, error: null, cookieStr: result);
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

  Stream<ProfileState> _handleGetNumbers(GetNumbers event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.getNumbers();
      if(result is List<String>){
        yield state.copyWith(loading: false, error: null, numbers: result);
      }
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
}