import 'package:get_it/get_it.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/usecases/update_app_theme.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/init_google_map.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_theme.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_route.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_position.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_destinations.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/utils/mock_geo_service.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  _initCore();
  _initGoogleMap();
}

void _initCore() {
  /// Blocs
  locator.registerLazySingleton(() => AppBloc(
        AppBlocState.initial(),
      ));

  locator.registerLazySingleton(() => UpdateAppTheme(
        appBloc: locator<AppBloc>(),
        updateMapTheme: locator<UpdateMapTheme>(),
      ));
}

void _initGoogleMap() {
  /// Blocs
  locator.registerLazySingleton(() => GeoBloc(
        GeoBlocState.initial(),
      ));

  /// Utils
  locator.registerLazySingleton(() => MockGeoService(
        updateCurrentPosition: locator<UpdateCurrentPosition>(),
        updateAnotherPositions: locator<UpdateAnotherPositions>(),
      ));
  locator.registerLazySingleton(() => MapUtils());

  /// Usecases
  locator.registerLazySingleton(() => InitGoogleMap(
        bloc: locator<GeoBloc>(),
        mapUtils: locator<MapUtils>(),
        mockGeoService: locator<MockGeoService>(),
        updateCurrentPosition: locator<UpdateCurrentPosition>(),
        updateCurrentDestination: locator<UpdateCurrentDestination>(),
        updateAnotherPositions: locator<UpdateAnotherPositions>(),
        updateAnotherDestinations: locator<UpdateAnotherDestinations>(),
      ));

  locator.registerLazySingleton(() => UpdateCurrentPosition(
        bloc: locator<GeoBloc>(),
        updateRouteUsecase: locator<UpdateCurrentRoute>(),
      ));
  locator.registerLazySingleton(() => UpdateCurrentDestination(
        bloc: locator<GeoBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateCurrentRoute(
        bloc: locator<GeoBloc>(),
        mapUtils: locator<MapUtils>(),
      ));

  locator.registerLazySingleton(() => UpdateAnotherPositions(
        bloc: locator<GeoBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateAnotherDestinations(
        bloc: locator<GeoBloc>(),
      ));

  locator.registerLazySingleton(() => UpdateMapUtils(
        bloc: locator<GeoBloc>(),
        updateRouteUsecase: locator<UpdateCurrentRoute>(),
      ));
  locator.registerLazySingleton(() => UpdateMapTheme(
        bloc: locator<GeoBloc>(),
      ));
}
