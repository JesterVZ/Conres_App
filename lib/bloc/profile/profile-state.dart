class ProfileState {
  final String? cookieStr;
  final bool? loading;
  final String? error;

  ProfileState({this.cookieStr, this.loading, this.error});

  static initial() => ProfileState(
        cookieStr: null,
        loading: null,
        error: null
      );
  ProfileState copyWith({
    String? cookieStr,
    bool? loading,
    String? error
  }){
    return ProfileState(
      error: error,
      loading: loading ?? this.loading,
      cookieStr: cookieStr ?? this.cookieStr
    );
  }
}
