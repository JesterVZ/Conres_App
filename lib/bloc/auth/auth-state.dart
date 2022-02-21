class AuthState{
  final bool? loading;
  final Object? error;

  AuthState({this.loading, this.error});

  static initial() => AuthState(
    loading: false,
    error: null,
  );

  AuthState copyWith({
    bool? loading,
    Object? error,
  }){
    return AuthState(
        loading: loading ?? this.loading,
        error: error
    );
  }
}