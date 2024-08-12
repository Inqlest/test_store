class RegistrationState {
  final bool isLoading;

  RegistrationState({
    this.isLoading = false,
  });

  RegistrationState copyWith({
    bool? isLoading,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
