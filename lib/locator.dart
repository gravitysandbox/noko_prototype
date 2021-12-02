import 'package:get_it/get_it.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/usecases/update_app_theme.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_state.dart';
import 'package:noko_prototype/src/features/garage/domain/datasources/garage_remote_datasource.dart';
import 'package:noko_prototype/src/features/garage/domain/usecases/update_all_schedules.dart';
import 'package:noko_prototype/src/features/garage/domain/usecases/update_all_timetables.dart';
import 'package:noko_prototype/src/features/garage/domain/usecases/update_all_vehicles.dart';
import 'package:noko_prototype/src/features/garage/domain/usecases/init_garage_screen.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/datasources/map_remote_datasource.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/init_map_screen.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_destinations.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_nearest_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_theme.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_route.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_position.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_vehicle.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_updater.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/utils/marker_generator.dart';

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
        updateYourPosition: locator<UpdateYourPosition>(),
        updateNearestPositions: locator<UpdateNearestPositions>(),
        updateAnotherPositions: locator<UpdateAnotherPositions>(),
      ));
  locator.registerLazySingleton(() => MarkerGenerator());

  /// Usecases
  locator.registerLazySingleton(() => InitMapScreen(
        geoBloc: locator<GeoBloc>(),
        garageBloc: locator<GarageBloc>(),
        mapUtils: locator<MapUtils>(),
        mapRemoteDatasource: locator<MapRemoteDatasource>(),
        updateYourPosition: locator<UpdateYourPosition>(),
        updateYourDestination: locator<UpdateYourDestination>(),
        updateNearestPositions: locator<UpdateNearestPositions>(),
        updateAnotherDestinations: locator<UpdateAnotherDestinations>(),
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
  locator.registerLazySingleton(() => UpdateNearestPositions(
        bloc: locator<GeoBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateMapUtils(
        bloc: locator<GeoBloc>(),
        updateRouteUsecase: locator<UpdateYourRoute>(),
      ));
  locator.registerLazySingleton(() => UpdateMapTheme(
        bloc: locator<GeoBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateAnotherDestinations(
        bloc: locator<GeoBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateAnotherPositions(
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

  /// Usecases
  locator.registerLazySingleton(() => InitGarageScreen(
        bloc: locator<GarageBloc>(),
        garageRemoteDatasource: locator<GarageRemoteDatasource>(),
        mapRemoteDatasource: locator<MapRemoteDatasource>(),
        updateAllVehicles: locator<UpdateAllVehicles>(),
        updateAllSchedules: locator<UpdateAllSchedules>(),
        updateAllTimetables: locator<UpdateAllTimetables>(),
        updateYourVehicle: locator<UpdateYourVehicle>(),
      ));
  locator.registerLazySingleton(() => UpdateAllVehicles(
        bloc: locator<GarageBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateAllSchedules(
        bloc: locator<GarageBloc>(),
      ));
  locator.registerLazySingleton(() => UpdateAllTimetables(
        bloc: locator<GarageBloc>(),
      ));
}
