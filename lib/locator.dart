import 'package:get_it/get_it.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/models/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/init_google_map.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_markers.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_polylines.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_position.dart';
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
        updatePolylinesUsecase: locator<UpdatePolylines>(),
        updatePositionUsecase: locator<UpdatePosition>(),
      ));

  locator.registerLazySingleton(() => UpdateMarkers(
        bloc: locator<GeolocationBloc>(),
      ));
  locator.registerLazySingleton(() => UpdatePolylines(
        bloc: locator<GeolocationBloc>(),
      ));
  locator.registerLazySingleton(() => UpdatePosition(
        bloc: locator<GeolocationBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateMapUtils(
        bloc: locator<GeolocationBloc>(),
      ));

  /// Utils
  locator.registerLazySingleton(() => ShadowGeolocationUpdater(
        updatePositionUsecase: locator<UpdatePosition>(),
      ));
  locator.registerLazySingleton(() => MapUtils());
}
