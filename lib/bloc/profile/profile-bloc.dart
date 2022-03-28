import 'package:bloc/bloc.dart';
import 'package:conres_app/bloc/profile/profile-event.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';

import '../../repositories/profile-repo.dart';

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
  }

  ProfileBloc(this.repo) : super(ProfileState.initial());

  getCookies(String username, String password, int type){
    add(GetCookieStrEvent(username, password, type));
  }

  getLoginData(){
    add(const GetLoginData());
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
}