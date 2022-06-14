class MoviesState {

  const MoviesState({
    this.isLoading = false,
    this.error,
  });
  final bool isLoading;
  final String? error;

  MoviesState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return MoviesState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
