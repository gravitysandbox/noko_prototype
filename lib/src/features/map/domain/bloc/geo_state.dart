import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_position.dart';

enum MapIconBitmap {
  you,
  another,
  busStop,
}

enum MapThemeStyle {
  light,
  dark,
}

class GeoBlocState {
  final VehicleData? yourVehicle;
  final VehiclePosition? yourPosition;
  final VehicleRouteDestination? yourDestination;
  final List<LatLng> yourRoute;

  final List<VehiclePosition>? anotherPositions;

  final Map<MapIconBitmap, BitmapDescriptor>? icons;
  final MapUtilsState utils;
  final Map<MapThemeStyle, String>? mapThemes;
  final MapThemeStyle currentMapTheme;

  const GeoBlocState({
    this.yourVehicle,
    this.yourPosition,
    this.yourDestination,
    this.yourRoute = const [],
    this.anotherPositions = const [],
    this.icons,
    this.utils = const MapUtilsState(),
    this.mapThemes = const {},
    this.currentMapTheme = MapThemeStyle.light,
  });

  factory GeoBlocState.initial() {
    return const GeoBlocState(
      utils: MapUtilsState(
        isTrackingEnabled: false,
        isTrafficEnabled: false,
        isRouteEnabled: false,
        isRouteReversed: false,
      ),
      currentMapTheme: MapThemeStyle.light,
    );
  }

  GeoBlocState copyWith({
    VehicleData? yourVehicle,
    VehiclePosition? yourPosition,
    VehicleRouteDestination? yourDestination,
    List<LatLng>? yourRoute,
    List<VehiclePosition>? anotherPositions,
    Set<VehicleRouteDestination>? anotherDestinations,
    Map<MapIconBitmap, BitmapDescriptor>? icons,
    MapUtilsState? utils,
    Map<MapThemeStyle, String>? mapThemes,
    MapThemeStyle? currentMapTheme,
  }) {
    return GeoBlocState(
      yourVehicle: yourVehicle ?? this.yourVehicle,
      yourPosition: yourPosition ?? this.yourPosition,
      yourDestination: yourDestination ?? this.yourDestination,
      yourRoute: yourRoute ?? this.yourRoute,
      anotherPositions: anotherPositions ?? this.anotherPositions,
      icons: icons ?? this.icons,
      utils: utils != null ? this.utils.copyWith(utils) : this.utils,
      mapThemes: mapThemes ?? this.mapThemes,
      currentMapTheme: currentMapTheme ?? this.currentMapTheme,
    );
  }
}

class MapUtilsState {
  final bool? isTrackingEnabled;
  final bool? isTrafficEnabled;
  final bool? isRouteEnabled;
  final bool? isRouteReversed;

  const MapUtilsState({
    this.isTrackingEnabled,
    this.isTrafficEnabled,
    this.isRouteEnabled,
    this.isRouteReversed,
  });

  MapUtilsState copyWith(MapUtilsState newState) {
    return MapUtilsState(
      isTrackingEnabled: newState.isTrackingEnabled ?? isTrackingEnabled,
      isTrafficEnabled: newState.isTrafficEnabled ?? isTrafficEnabled,
      isRouteEnabled: newState.isRouteEnabled ?? isRouteEnabled,
      isRouteReversed: newState.isRouteReversed ?? isRouteReversed,
    );
  }
}
