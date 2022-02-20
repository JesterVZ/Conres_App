import 'package:bloc/bloc.dart';
import 'package:conres_app/model/result-data.dart';
import 'package:conres_app/repositories/auth-repo.dart';

import 'auth-event.dart';
import 'auth-state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo repo;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if(event is RegisterEvent){
      yield* _handleRegisterEvent(event);
    }
    if(event is LoginEvent){
      yield*
    }
  }
  AuthBloc(this.repo) : super(AuthState.initial());

  register(Object sender){
    add(RegisterEvent(sender));
  }

  login(String username, String password){
    add(LoginEvent(username, password));
  }

  Stream<AuthState> _handleRegisterEvent(RegisterEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.registration(event.sender);
      if(result is ResultData){
        yield state.copyWith(loading: false, error: null);
      } else {
        yield state.copyWith(error: "Test error", loading: false);
      }
    } catch(e){
      yield state.copyWith(error: e.toString(), loading: false);
    }
  }

  Stream<AuthState> _handleLoginEvent(LoginEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      Object result = await repo.getCookies(event.username, event.password);
      if(result is List){
        Object loginResult = await repo.l
      }
    }
  }
}
