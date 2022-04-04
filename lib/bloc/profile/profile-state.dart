class ProfileState {
  final String? cookieStr;
  final bool? loading;
  final String? error;
  final List<dynamic>? loginData;
  final dynamic webSocketData;

  ProfileState({this.loginData, this.cookieStr, this.loading, this.error, this.webSocketData});

  static initial() => ProfileState(
        cookieStr: null,
        loading: null,
        error: null
      );
  ProfileState copyWith({
    String? cookieStr,
    bool? loading,
    List<dynamic>? loginData,
    String? error
  }){
    return ProfileState(
      error: error,
      loading: loading ?? this.loading,
      cookieStr: cookieStr ?? this.cookieStr,
      loginData: loginData ?? this.loginData
    );
  }
}
