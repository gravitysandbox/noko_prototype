class AppBlocState {
  final bool isDarkTheme;

  const AppBlocState({
    required this.isDarkTheme,
  });

  factory AppBlocState.initial() {
    return const AppBlocState(
      isDarkTheme: false,
    );
  }

  AppBlocState update({bool? isDarkTheme}) {
    return AppBlocState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}
