import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';

class GeoBloc extends Bloc<GeoBlocEvent, GeoBlocState> {
  GeoBloc(GeoBlocState initialState) : super(initialState);

  @override
  Stream<GeoBlocState> mapEventToState(
      GeoBlocEvent event) async* {
    logPrint('***** GeolocationBloc mapEventToState(): ${event.runtimeType}');
    switch (event.runtimeType) {
      case GeoUpdateIcons:
        {
          var snapshot = event as GeoUpdateIcons;
          yield state.copyWith(
            myPositionIcon: snapshot.myPositionIcon,
            busStopIcon: snapshot.busStopIcon,
            shuttleIcon: snapshot.shuttleIcon,
          );
          break;
        }

      case GeoUpdateCurrentPosition:
        {
          var snapshot = event as GeoUpdateCurrentPosition;
          yield state.copyWith(
            currentPosition: snapshot.currentPosition,
          );
          break;
        }

      case GeoUpdateCurrentDestination:
        {
          var snapshot = event as GeoUpdateCurrentDestination;
          yield state.copyWith(
            currentDestination: snapshot.currentDestination,
          );
          break;
        }

      case GeoUpdateCurrentRoute:
        {
          var snapshot = event as GeoUpdateCurrentRoute;
          yield state.copyWith(
            currentRoute: snapshot.currentRoute,
          );
          break;
        }

      case GeoUpdateAnotherPositions:
        {
          var snapshot = event as GeoUpdateAnotherPositions;
          yield state.copyWith(
            anotherPositions: snapshot.anotherPositions,
          );
          break;
        }

      case GeoUpdateAnotherDestinations:
        {
          var snapshot = event as GeoUpdateAnotherDestinations;
          yield state.copyWith(
            anotherDestinations: snapshot.anotherDestinations,
          );
          break;
        }

      case GeoUpdateMapUtils:
        {
          var snapshot = event as GeoUpdateMapUtils;
          yield state.copyWith(
            utils: snapshot.utilsState,
          );
          break;
        }

      case GeoInitMapThemes:
        {
          var snapshot = event as GeoInitMapThemes;
          yield state.copyWith(
            mapThemes: snapshot.mapThemes,
          );
          break;
        }

      case GeoUpdateMapTheme:
        {
          var snapshot = event as GeoUpdateMapTheme;
          yield state.copyWith(
            currentMapTheme: snapshot.mapTheme,
          );
          break;
        }
    }
  }
}
