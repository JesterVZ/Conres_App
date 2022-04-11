import '../../model/contract.dart';
import '../../model/meter.dart';
import '../../model/profile.dart';
import '../../model/result-data.dart';

class AuthState{
  final String? cookieStr;
  final Profile? profile;
  final bool? loading;
  final Object? error;
  final List<Meter>? testimony;
  final List<dynamic>? loginData;
  final List<Contract>? contracts;
  final List<String>? numbers;
  final dynamic webSocketData;
  final ResultData? bindLsData;


  AuthState({this.loginData, this.loading, this.error, this.profile, this.testimony, this.numbers, this.bindLsData, this.contracts, this.cookieStr, this.webSocketData});

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
    String? cookieStr,
    List<Contract>? contracts,
    List<String>? numbers,
    dynamic webSocketData,
    ResultData? bindLsData
  }){
    return AuthState(
        profile: profile ?? this.profile,
        loading: loading ?? this.loading,
        loginData: loginData ?? this.loginData,
        testimony: testimony ?? this.testimony,
        bindLsData: bindLsData ?? this.bindLsData,
        contracts: contracts ?? this.contracts,
        cookieStr: cookieStr ?? this.cookieStr,
        numbers: numbers ?? this.numbers,
        webSocketData: webSocketData ?? this.webSocketData,
        error: error
    );
  }

  @override
  String toString() {
    return '{profile: $profile, loading: $loading, error: $error, loginData: $loginData, testimont: $testimony}';
  }
}