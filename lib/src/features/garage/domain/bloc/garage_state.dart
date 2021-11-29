class GarageBlocState {
  final bool test;

  const GarageBlocState({
    required this.test,
  });

  factory GarageBlocState.initial() {
    return const GarageBlocState(
      test: true,
    );
  }

  GarageBlocState copyWith({
    bool? test,
  }) {
    return GarageBlocState(
      test: test ?? this.test,
    );
  }
}
