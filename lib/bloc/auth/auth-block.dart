import 'package:bloc/bloc.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:conres_app/repositories/auth-repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/meter.dart';
import '../../model/profile.dart';
import '../../shared-preferences/shared-preferences.dart';
import 'auth-event.dart';
import 'auth-state.dart';

class AuthBloc extends Bloc<Event, AuthState> {
  final AuthRepo repo;

  @override
  Stream<AuthState> mapEventToState(Event event) async* {
    if(event is RegisterEvent){
      yield* _handleRegisterEvent(event);
    }
    if(event is LoginEvent){
      yield* _handleLoginEvent(event);
    }

    if(event is GetLoginEvent){
      yield* _handleGetLogin(event);
    }

    if(event is GetTestimony){
      yield* _handleGetTestimony(event);
    }


  }
  AuthBloc(this.repo) : super(AuthState.initial());

  register(Object sender, int type){
    add(RegisterEvent(sender, type));
  }

  login(String username, String password, int type){
    add(LoginEvent(username, password, type));
  }

  getLogin(){
    add(const GetLoginEvent());
  }

  getTestimony(){
    add(const GetTestimony());
  }

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

  Stream<AuthState> _handleRegisterEvent(RegisterEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object? result = await repo.registration(event.sender);
      if(result is ResultData){
        yield state.copyWith(loading: false, error: null);
      } else if(result is Map<dynamic, dynamic>) {
        yield state.copyWith(error: result, loading: false);
      }
    } catch(e){
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<AuthState> _handleLoginEvent(LoginEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.getCookies(event.username, event.password, event.type);
      if(result is List){
        Object? loginResult = await repo.login(result);
        if(loginResult is Profile){
          SharedPreferences preferences = await SharedPreferences.getInstance();
          setLogin(preferences, event.username, event.password, event.type);
          List<dynamic> loginData = [event.username, event.password, event.type];
          yield state.copyWith(profile: loginResult, loginData: loginData, error: null, loading: false);
        } else {
          yield state.copyWith(error: loginResult.toString(), loading: false);
        }
      } else {
        yield state.copyWith(error: result.toString(), loading: false);
      }
    }catch(e){
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<AuthState> _handleGetLogin(GetLoginEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.loginData();
      if(result is List<dynamic>){
        yield state.copyWith(loginData: result, loading: false, error: null);
      }
    }catch(e){
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<AuthState> _handleGetTestimony(GetTestimony event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object? result = await repo.getTestimonyFunc();
      if(result is List<Meter>){
        yield state.copyWith(testimony: result, loading: false, error: null);
      }
    } catch(e){
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<AuthState> _handleGetCookies(GetCookieStrEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      String result = await repo.getCookie(event.username, event.password, event.type);

      yield state.copyWith(loading: false, error: null, cookieStr: result);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
  Stream<AuthState> _handleGetData(GetLoginData event) async*{
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
  Stream<AuthState> _handleGetWebSocketData(GetWebSocketData event) async*{
    yield state.copyWith(loading: true, error: null);
    try{

    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
  Stream<AuthState> _handleLogout(LogoutEvent event) async*{
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

  Stream<AuthState> _handleBindNewLS(BindNewLS event) async*{
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

  Stream<AuthState> _handleGetContracts(GetContracts event) async*{
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

  Stream<AuthState> _handleGetNumbers(GetNumbers event) async*{
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
