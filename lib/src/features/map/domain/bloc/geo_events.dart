import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_position.dart';

abstract class GeoBlocEvent {
  const GeoBlocEvent([List props = const []]) : super();
}

class GeoUpdateYourVehicle extends GeoBlocEvent {
  final int yourVehicleID;

  GeoUpdateYourVehicle({
    required this.yourVehicleID,
  }) : super([yourVehicleID]);
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

class GeoUpdateYourCurrentData extends GeoBlocEvent {
  final VehicleRouteData yourData;

  GeoUpdateYourCurrentData({
    required this.yourData,
  }) : super([yourData]);
}

class GeoUpdateSelectedVehicles extends GeoBlocEvent {
  final List<int> vehicles;

  GeoUpdateSelectedVehicles({
    required this.vehicles,
  }) : super([vehicles]);
}

class GeoUpdateNearestPositions extends GeoBlocEvent {
  final List<VehiclePosition> nearestPositions;

  GeoUpdateNearestPositions({
    required this.nearestPositions,
  }) : super([nearestPositions]);
}

class GeoUpdateAnotherDestinations extends GeoBlocEvent {
  final List<VehicleRouteDestination> anotherDestinations;

  GeoUpdateAnotherDestinations({
    required this.anotherDestinations,
  }) : super([anotherDestinations]);
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

class GeoUpdateMapMode extends GeoBlocEvent {
  final bool isInit;

  GeoUpdateMapMode({
    required this.isInit,
  }) : super([isInit]);
}
