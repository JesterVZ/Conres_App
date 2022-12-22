import 'package:bloc/bloc.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:conres_app/model/store.dart';
import 'package:conres_app/repositories/auth-repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/meter.dart';
import '../../model/profile.dart';
import '../../shared-preferences/shared-preferences.dart';
import 'auth-event.dart';
import 'auth-state.dart';
/* 
AuthBloc
Bloc-файл для регистрации и входа

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class AuthBloc extends Bloc<Event, AuthState> {
  final AuthRepo repo;

  @override
  Stream<AuthState> mapEventToState(Event event) async* {
    if (event is RegisterEvent) {
      yield* _handleRegisterEvent(event);
    } else if (event is LoginEvent) {
      yield* _handleLoginEvent(event);
    } else if (event is GetLoginEvent) {
      yield* _handleGetLogin(event);
    } else if (event is GetStores) {
      yield* _handleGetStores(event);
    } else if (event is CookieLogin) {
      yield* _handleCookiesLogin(event);
    }
  }

  AuthBloc(this.repo) : super(AuthState.initial());

  register(Object sender, int type) {
    add(RegisterEvent(sender, type));
  }

  login(String username, String password, int type) {
    add(LoginEvent(username, password, type));
  }

  getLogin() {
    add(const GetLoginEvent());
  }

  getStores() {
    add(const GetStores());
  }

  loginWithCookies() {
    add(CookieLogin());
  }

  Stream<AuthState> _handleRegisterEvent(RegisterEvent event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object? result = await repo.registration(event.sender);
      if (result is ResultData) {
        yield state.copyWith(loading: false, error: null);
      } else if (result is Map<dynamic, dynamic>) {
        yield state.copyWith(error: result, loading: false);
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<AuthState> _handleLoginEvent(LoginEvent event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object result =
          await repo.getCookies(event.username, event.password, event.type);
      if (result is List) {
        //если результат - лист из cookie
        SharedPreferences preferences = await SharedPreferences.getInstance();
        setLogin(preferences, event.username, event.password, event.type);
        List<dynamic> loginData = [event.username, event.password, event.type];
        yield state.copyWith(
            loading: false, error: null, cookies: result, loginData: loginData);
      } else {
        yield state.copyWith(error: result.toString(), loading: false);
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<AuthState> _handleGetLogin(GetLoginEvent event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object result = await repo.loginData();
      if (result is List<dynamic>) {
        yield state.copyWith(loginData: result, loading: false, error: null);
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<AuthState> _handleGetStores(GetStores event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object? result = await repo.getStores();
      if (result is List<Store>) {
        yield state.copyWith(stors: result, loading: false, error: null);
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<AuthState> _handleCookiesLogin(CookieLogin event) async* {
    yield state.copyWith(loading: true, error: null);
    try {
      Object? loginResult = await repo.login();
      if (loginResult is Profile) {
        yield state.copyWith(profile: loginResult, error: null, loading: false);
      } else {
        yield state.copyWith(error: loginResult.toString(), loading: false);
      }
    } catch (e) {
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }
}
