import '../../model/meter.dart';
import '../../model/profile.dart';

class AuthState{
  final bool? isLogin;
  final Profile? profile;
  final bool? loading;
  final Object? error;
  final List<Meter>? testimony;
  final List<dynamic>? loginData;

  AuthState({this.loginData, this.loading, this.error, this.profile, this.isLogin, this.testimony});

  static initial() => AuthState(
    profile: null,
    loading: false,
    error: null,
  );

  AuthState copyWith({
    bool? isLogin,
    Profile? profile,
    bool? loading,
    Object? error,
    List<dynamic>? loginData,
    List<Meter>? testimony
  }){
    return AuthState(
        isLogin: isLogin ?? this.isLogin,
        profile: profile ?? this.profile,
        loading: loading ?? this.loading,
        loginData: loginData ?? this.loginData,
        testimony: testimony ?? this.testimony,
        error: error
    );
  }

  @override
  String toString() {
    return '{isLogin: $isLogin, profile: $profile, loading: $loading, error: $error, loginData: $loginData, testimont: $testimony}';
  }
}