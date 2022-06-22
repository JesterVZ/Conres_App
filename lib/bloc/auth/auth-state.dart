import '../../model/meter.dart';
import '../../model/profile.dart';
import '../../model/store.dart';

class AuthState{
  final Profile? profile;
  final bool? loading;
  final Object? error;
  final List<Meter>? testimony;
  final List<dynamic>? loginData;
  final List<Store>? stors;

  AuthState({this.loginData, this.loading, this.error, this.profile, this.testimony, this.stors});

  static initial() => AuthState(
    profile: null,
    loading: false,
    error: null,
  );

  AuthState copyWith({
    Profile? profile,
    bool? loading,
    Object? error,
    List<dynamic>? loginData,
    List<Meter>? testimony,
    List<Store>? stors
  }){
    return AuthState(
        profile: profile ?? this.profile,
        loading: loading ?? this.loading,
        loginData: loginData ?? this.loginData,
        testimony: testimony ?? this.testimony,
        stors: stors ?? this.stors,
        error: error
    );
  }

  @override
  String toString() {
    return '{profile: $profile, loading: $loading, error: $error, loginData: $loginData, testimont: $testimony}';
  }
}