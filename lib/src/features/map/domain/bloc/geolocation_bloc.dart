import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/events/geolocation_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  GeolocationBloc(GeolocationState initialState) : super(initialState);

  @override
  Stream<GeolocationState> mapEventToState(GeolocationEvent event) async* {
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

      case GeolocationUpdatePolylines:
        {
          var snapshot = event as GeolocationUpdatePolylines;
          yield state.update(
            routePolylines: snapshot.polylinesCoordinates,
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
    }
  }
}
