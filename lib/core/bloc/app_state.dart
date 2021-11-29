class AppBlocState {
  final int currentScreen;
  final bool isDarkTheme;

  const AppBlocState({
    required this.currentScreen,
    required this.isDarkTheme,
  });

  factory AppBlocState.initial() {
    return const AppBlocState(
      currentScreen: 0,
      isDarkTheme: false,
    );
  }

  AppBlocState update({int? currentScreen, bool? isDarkTheme}) {
    return AppBlocState(
      currentScreen: currentScreen ?? this.currentScreen,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}
