import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_events.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationBlocEvent, GeolocationBlocState> {
  GeolocationBloc(GeolocationBlocState initialState) : super(initialState);

  @override
  Stream<GeolocationBlocState> mapEventToState(
      GeolocationBlocEvent event) async* {
    logPrint('***** GeolocationBloc mapEventToState(): ${event.runtimeType}');
    switch (event.runtimeType) {
      case GeolocationUpdateIcons:
        {
          var snapshot = event as GeolocationUpdateIcons;
          yield state.update(
            myPositionIcon: snapshot.myPositionIcon,
            busStopIcon: snapshot.busStopIcon,
            shuttleIcon: snapshot.shuttleIcon,
          );
          break;
        }

      case GeolocationUpdatePosition:
        {
          var snapshot = event as GeolocationUpdatePosition;
          yield state.update(
            currentPosition: snapshot.currentPosition,
          );
          break;
        }

      case GeolocationUpdateMarkers:
        {
          var snapshot = event as GeolocationUpdateMarkers;
          yield state.update(
            busStopPositions: snapshot.markersCoordinates,
          );
          break;
        }

      case GeolocationUpdateRoutes:
        {
          var snapshot = event as GeolocationUpdateRoutes;
          yield state.update(
            routesPositions: snapshot.routesCoordinates,
          );
          break;
        }

      case GeolocationUpdateCurrentRoute:
        {
          var snapshot = event as GeolocationUpdateCurrentRoute;
          yield state.update(
            currentRoute: snapshot.routeCoordinates,
          );
          break;
        }

      case GeolocationUpdateMapUtils:
        {
          var snapshot = event as GeolocationUpdateMapUtils;
          yield state.update(
            utils: snapshot.utilsState,
          );
          break;
        }

      case GeolocationInitMapThemes:
        {
          var snapshot = event as GeolocationInitMapThemes;
          yield state.update(
            mapThemes: snapshot.mapThemes,
          );
          break;
        }

      case GeolocationUpdateMapTheme:
        {
          var snapshot = event as GeolocationUpdateMapTheme;
          yield state.update(
            currentMapTheme: snapshot.mapTheme,
          );
          break;
        }
    }
  }
}
