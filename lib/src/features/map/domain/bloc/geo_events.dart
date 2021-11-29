import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_position.dart';

abstract class GeoBlocEvent {
  const GeoBlocEvent([List props = const []]) : super();
}

class GeoUpdateYourVehicle extends GeoBlocEvent {
  final VehicleData yourVehicle;

  GeoUpdateYourVehicle({
    required this.yourVehicle,
  }) : super([yourVehicle]);
}

class GeoUpdateYourPosition extends GeoBlocEvent {
  final VehiclePosition yourPosition;

  GeoUpdateYourPosition({
    required this.yourPosition,
  }) : super([yourPosition]);
}

class GeoUpdateYourDestination extends GeoBlocEvent {
  final VehicleRouteDestination yourDestination;

  GeoUpdateYourDestination({
    required this.yourDestination,
  }) : super([yourDestination]);
}

class GeoUpdateYourRoute extends GeoBlocEvent {
  final List<LatLng> yourRoute;

  GeoUpdateYourRoute({
    required this.yourRoute,
  }) : super([yourRoute]);
}

class GeoUpdateAnotherPositions extends GeoBlocEvent {
  final List<VehiclePosition> anotherPositions;

  GeoUpdateAnotherPositions({
    required this.anotherPositions,
  }) : super([anotherPositions]);
}

class GeoUpdateIcons extends GeoBlocEvent {
  final Map<MapIconBitmap, BitmapDescriptor> icons;

  GeoUpdateIcons({
    required this.icons,
  }) : super([icons]);
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

class GeoUpdateCurrentMapTheme extends GeoBlocEvent {
  final MapThemeStyle mapTheme;

  GeoUpdateCurrentMapTheme({
    required this.mapTheme,
  }) : super([mapTheme]);
}
