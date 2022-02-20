class AuthState{
  final bool? loading;
  final String? error;

  AuthState({this.loading, this.error});

  static initial() => AuthState(
    loading: false,
    error: null,
  );

  AuthState copyWith({
    bool? loading,
    String? error,
  }){
    return AuthState(
        loading: loading ?? this.loading,
        error: error
    );
  }
}