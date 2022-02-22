import '../../model/profile.dart';

class AuthState{
  final Profile? profile;
  final bool? loading;
  final Object? error;

  AuthState({this.loading, this.error, this.profile});

  static initial() => AuthState(
    profile: null,
    loading: false,
    error: null,
  );

  AuthState copyWith({
    Profile? profile,
    bool? loading,
    Object? error,
  }){
    return AuthState(
        profile: profile ?? this.profile,
        loading: loading ?? this.loading,
        error: error
    );
  }
}