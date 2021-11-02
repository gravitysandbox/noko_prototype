import 'package:get_it/get_it.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/usecases/update_app_theme.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/init_google_map.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_theme.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_markers.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_route.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_position.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_routes.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/utils/shadow_geolocation_updater.dart';

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
  locator.registerLazySingleton(() => GeolocationBloc(
        GeolocationBlocState.initial(),
      ));

  /// Utils
  locator.registerLazySingleton(() => ShadowGeolocationUpdater(
        updatePositionUsecase: locator<UpdatePosition>(),
      ));
  locator.registerLazySingleton(() => MapUtils());

  /// Usecases
  locator.registerLazySingleton(() => InitGoogleMap(
        bloc: locator<GeolocationBloc>(),
        mapUtils: locator<MapUtils>(),
        geolocationUpdater: locator<ShadowGeolocationUpdater>(),
        updateMarkersUsecase: locator<UpdateMarkers>(),
        updateRoutesUsecase: locator<UpdateRoutes>(),
        updatePositionUsecase: locator<UpdatePosition>(),
      ));
  locator.registerLazySingleton(() => UpdateMarkers(
        bloc: locator<GeolocationBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateRoutes(
        bloc: locator<GeolocationBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateCurrentRoute(
        bloc: locator<GeolocationBloc>(),
        mapUtils: locator<MapUtils>(),
      ));
  locator.registerLazySingleton(() => UpdatePosition(
        bloc: locator<GeolocationBloc>(),
        updateRouteUsecase: locator<UpdateCurrentRoute>(),
      ));
  locator.registerLazySingleton(() => UpdateMapUtils(
        bloc: locator<GeolocationBloc>(),
        updateRouteUsecase: locator<UpdateCurrentRoute>(),
      ));
  locator.registerLazySingleton(() => UpdateMapTheme(
        bloc: locator<GeolocationBloc>(),
      ));
}
