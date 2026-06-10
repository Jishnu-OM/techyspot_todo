class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;

  const AuthState({
    this.isLoading = false,
    this.errorMessage,
    this.isLoggedIn = false,
  });

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
