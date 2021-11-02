import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';

abstract class GeolocationBlocEvent {
  const GeolocationBlocEvent([List props = const []]) : super();
}

class GeolocationUpdateIcons extends GeolocationBlocEvent {
  final BitmapDescriptor myPositionIcon;
  final BitmapDescriptor busStopIcon;
  final BitmapDescriptor shuttleIcon;

  GeolocationUpdateIcons({
    required this.myPositionIcon,
    required this.busStopIcon,
    required this.shuttleIcon,
  }) : super([
          myPositionIcon,
          busStopIcon,
          shuttleIcon,
        ]);
}

class GeolocationUpdatePosition extends GeolocationBlocEvent {
  final LatLng currentPosition;

  GeolocationUpdatePosition({
    required this.currentPosition,
  }) : super([currentPosition]);
}

class GeolocationUpdateMarkers extends GeolocationBlocEvent {
  final Map<String, LatLng> markersCoordinates;

  GeolocationUpdateMarkers({
    required this.markersCoordinates,
  }) : super([markersCoordinates]);
}

class GeolocationUpdateRoutes extends GeolocationBlocEvent {
  final Set<RouteDestinationModel> routesCoordinates;

  GeolocationUpdateRoutes({
    required this.routesCoordinates,
  }) : super([routesCoordinates]);
}

class GeolocationUpdateCurrentRoute extends GeolocationBlocEvent {
  final List<LatLng> routeCoordinates;

  GeolocationUpdateCurrentRoute({
    required this.routeCoordinates,
  }) : super([routeCoordinates]);
}

class GeolocationUpdateMapUtils extends GeolocationBlocEvent {
  final MapUtilsState utilsState;

  GeolocationUpdateMapUtils({
    required this.utilsState,
  }) : super([utilsState]);
}

class GeolocationInitMapThemes extends GeolocationBlocEvent {
  final Map<MapThemeStyle, String> mapThemes;

  GeolocationInitMapThemes({
    required this.mapThemes,
  }) : super([mapThemes]);
}

class GeolocationUpdateMapTheme extends GeolocationBlocEvent {
  final MapThemeStyle mapTheme;

  GeolocationUpdateMapTheme({
    required this.mapTheme,
  }) : super([mapTheme]);
}