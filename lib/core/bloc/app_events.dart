abstract class AppBlocEvent {
  const AppBlocEvent([List props = const []]) : super();
}

class AppUpdateTheme extends AppBlocEvent {
  final bool isDarkTheme;

  AppUpdateTheme({
    required this.isDarkTheme,
  }) : super([isDarkTheme]);
}
