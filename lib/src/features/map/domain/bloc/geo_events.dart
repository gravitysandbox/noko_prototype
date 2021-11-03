import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_position_model.dart';

abstract class GeoBlocEvent {
  const GeoBlocEvent([List props = const []]) : super();
}

class GeoUpdateIcons extends GeoBlocEvent {
  final BitmapDescriptor myPositionIcon;
  final BitmapDescriptor busStopIcon;
  final BitmapDescriptor shuttleIcon;

  GeoUpdateIcons({
    required this.myPositionIcon,
    required this.busStopIcon,
    required this.shuttleIcon,
  }) : super([
          myPositionIcon,
          busStopIcon,
          shuttleIcon,
        ]);
}

class GeoUpdateCurrentPosition extends GeoBlocEvent {
  final RoutePositionModel currentPosition;

  GeoUpdateCurrentPosition({
    required this.currentPosition,
  }) : super([currentPosition]);
}

class GeoUpdateCurrentDestination extends GeoBlocEvent {
  final RouteDestinationModel currentDestination;

  GeoUpdateCurrentDestination({
    required this.currentDestination,
  }) : super([currentDestination]);
}

class GeoUpdateCurrentRoute extends GeoBlocEvent {
  final List<LatLng> currentRoute;

  GeoUpdateCurrentRoute({
    required this.currentRoute,
  }) : super([currentRoute]);
}

class GeoUpdateAnotherPositions extends GeoBlocEvent {
  final List<RoutePositionModel> anotherPositions;

  GeoUpdateAnotherPositions({
    required this.anotherPositions,
  }) : super([anotherPositions]);
}

class GeoUpdateAnotherDestinations extends GeoBlocEvent {
  final Set<RouteDestinationModel> anotherDestinations;

  GeoUpdateAnotherDestinations({
    required this.anotherDestinations,
  }) : super([anotherDestinations]);
}

class GeoUpdateMapUtils extends GeoBlocEvent {
  final MapUtilsState utilsState;

  GeoUpdateMapUtils({
    required this.utilsState,
  }) : super([utilsState]);
}

class GeoInitMapThemes extends GeoBlocEvent {
  final Map<MapThemeStyle, String> mapThemes;

  GeoInitMapThemes({
    required this.mapThemes,
  }) : super([mapThemes]);
}

class GeoUpdateMapTheme extends GeoBlocEvent {
  final MapThemeStyle mapTheme;

  GeoUpdateMapTheme({
    required this.mapTheme,
  }) : super([mapTheme]);
}
