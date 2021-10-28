import 'package:get_it/get_it.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/models/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/init_google_map.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_markers.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_route.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_position.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_routes.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/utils/shadow_geolocation_updater.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  /// Blocs
  locator.registerLazySingleton(() => GeolocationBloc(
        const GeolocationState(),
      ));

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

  /// Utils
  locator.registerLazySingleton(() => ShadowGeolocationUpdater(
        updatePositionUsecase: locator<UpdatePosition>(),
      ));
  locator.registerLazySingleton(() => MapUtils());
}
