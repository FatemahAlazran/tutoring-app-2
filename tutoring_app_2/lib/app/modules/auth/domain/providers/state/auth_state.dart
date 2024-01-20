class AuthState {
  final bool? isAuth;
  final bool? isLoading;
  final String? error;

  AuthState({
    this.isAuth,
    this.isLoading,
    this.error,
  });

  AuthState copyWith({
    bool? isAuth,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuth: isAuth ?? this.isAuth,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
