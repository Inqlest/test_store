class AuthorizationState {
  final bool isLoading;

  AuthorizationState({
    this.isLoading = false,
  });

  AuthorizationState copyWith({
    bool? isLoading,
  }) {
    return AuthorizationState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
