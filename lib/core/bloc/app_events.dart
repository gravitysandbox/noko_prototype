abstract class AppBlocEvent {
  const AppBlocEvent([List props = const []]) : super();
}

class AppUpdateScreen extends AppBlocEvent {
  final int currentScreen;

  AppUpdateScreen({
    required this.currentScreen,
  }) : super([currentScreen]);
}

class AppUpdateTheme extends AppBlocEvent {
  final bool isDarkTheme;

  AppUpdateTheme({
    required this.isDarkTheme,
  }) : super([isDarkTheme]);
}
