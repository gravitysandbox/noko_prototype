import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/constants.dart';
import 'package:noko_prototype/locator.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/presentation/screens/garage_screen.dart';
import 'package:noko_prototype/src/features/home/presentation/screens/home_screen.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/map_screen.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/map_settings_screen.dart';
import 'package:noko_prototype/src/features/map/presentation/screens/temp_screen.dart';

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
          value: locator<GeoBloc>(),
        ),
        BlocProvider.value(
          value: locator<GarageBloc>(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppBlocState>(
        buildWhen: (prev, current) {
          return prev.isDarkTheme != current.isDarkTheme;
        },
        builder: (context, state) {
          return MaterialApp(
            theme: state.isDarkTheme
                ? StyleConstants.kDarkTheme
                : StyleConstants.kLightTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: HomeScreen.routeName,
            routes: {
              HomeScreen.routeName: (context) => const HomeScreen(),
              MapScreen.routeName: (context) => const MapScreen(),
              MapSettingsScreen.routeName: (context) => const MapSettingsScreen(),
              TempScreen.routeName: (context) => const TempScreen(),
              GarageScreen.routeName: (context) => const GarageScreen(),
            },
          );
        },
      ),
    );
  }
}