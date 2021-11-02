import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/map_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: locator<AppBloc>(),
        ),
        BlocProvider.value(
          value: locator<GeolocationBloc>(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppBlocState>(
        buildWhen: (prev, current) {
          return prev.isDarkTheme != current.isDarkTheme;
        },
        builder: (context, state) {
          return MaterialApp(
            theme: state.isDarkTheme
                ? Constraints.kDarkTheme
                : Constraints.kLightTheme,
            debugShowCheckedModeBanner: false,
            home: const PageSwitcher(),
          );
        },
      ),
    );
  }
}

class PageSwitcher extends StatefulWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  State<PageSwitcher> createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<Widget> _screens = const [
    MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: _bucket,
      child: _screens[0],
    );
  }
}
