import 'package:conres_app/model/result-data.dart';

import '../../model/contract.dart';

class ProfileState {
  final String? cookieStr;
  final bool? loading;
  final String? error;
  final List<dynamic>? loginData;
  final List<Contract>? contracts;
  final dynamic webSocketData;
  final ResultData? bindLsData;

  ProfileState(
      {this.loginData,
      this.cookieStr,
      this.loading,
      this.error,
      this.webSocketData,
      this.bindLsData,
      this.contracts});

  static initial() => ProfileState(cookieStr: null, loading: null, error: null);
  ProfileState copyWith(
      {String? cookieStr,
      bool? loading,
      List<dynamic>? loginData,
      ResultData? bindLsData,
      List<Contract>? contracts,
      String? error}) {
    return ProfileState(
        error: error,
        loading: loading ?? this.loading,
        cookieStr: cookieStr ?? this.cookieStr,
        loginData: loginData ?? this.loginData,
        bindLsData: bindLsData ?? this.bindLsData,
        contracts: contracts ?? this.contracts);
  }
}
