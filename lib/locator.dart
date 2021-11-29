import 'package:get_it/get_it.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/usecases/update_app_theme.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_state.dart';
import 'package:noko_prototype/src/features/garage/domain/datasources/garage_remote_datasource.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/datasources/map_remote_datasource.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/init_google_map.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_theme.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_route.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_position.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_vehicle.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_updater.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  _initCore();
  _initGoogleMap();
  _initGarage();
}

void _initCore() {
  /// Blocs
  locator.registerLazySingleton(() => AppBloc(
        AppBlocState.initial(),
      ));

  /// Usecases
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

  /// Datasources
  locator.registerLazySingleton(() => MapRemoteDatasource());

  /// Utils
  locator.registerLazySingleton(() => MapUtils());
  locator.registerLazySingleton(() => MapUpdater(
        bloc: locator<GeoBloc>(),
        mapRemoteDatasource: locator<MapRemoteDatasource>(),
        updateCurrentPosition: locator<UpdateYourPosition>(),
        updateAnotherPositions: locator<UpdateAnotherPositions>(),
      ));

  /// Usecases
  locator.registerLazySingleton(() => InitGoogleMap(
        bloc: locator<GeoBloc>(),
        mapUtils: locator<MapUtils>(),
        mapRemoteDatasource: locator<MapRemoteDatasource>(),
        updateYourVehicle: locator<UpdateYourVehicle>(),
        updateYourPosition: locator<UpdateYourPosition>(),
        updateYourDestination: locator<UpdateYourDestination>(),
        updateAnotherPositions: locator<UpdateAnotherPositions>(),
      ));
  locator.registerLazySingleton(() => UpdateYourVehicle(
        bloc: locator<GeoBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateYourPosition(
        bloc: locator<GeoBloc>(),
        updateRouteUsecase: locator<UpdateYourRoute>(),
      ));
  locator.registerLazySingleton(() => UpdateYourDestination(
        bloc: locator<GeoBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateYourRoute(
        bloc: locator<GeoBloc>(),
        mapUtils: locator<MapUtils>(),
      ));
  locator.registerLazySingleton(() => UpdateAnotherPositions(
        bloc: locator<GeoBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateMapUtils(
        bloc: locator<GeoBloc>(),
        updateRouteUsecase: locator<UpdateYourRoute>(),
      ));
  locator.registerLazySingleton(() => UpdateMapTheme(
        bloc: locator<GeoBloc>(),
      ));
}

void _initGarage() {
  /// Blocs
  locator.registerLazySingleton(() => GarageBloc(
        GarageBlocState.initial(),
      ));

  /// Datasources
  locator.registerLazySingleton(() => GarageRemoteDatasource());
}
