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
  }

  ProfileBloc(this.repo) : super(ProfileState.initial());

  getCookies(){
    add(const GetCookieStrEvent("wss://promo.dev.conres.ru:2450/"));
  }

  Stream<ProfileState> _handleGetCookies(GetCookieStrEvent event) async*{
    yield state.copyWith(loading: true, error: null);
    try{
      String result = await repo.getCookie(event.uri);
      yield state.copyWith(loading: false, error: null, cookieStr: result);
    }catch(e){
      yield state.copyWith(loading: false, error: e.toString());
    }
  }
}