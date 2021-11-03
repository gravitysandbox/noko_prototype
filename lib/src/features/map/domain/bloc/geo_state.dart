import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_position_model.dart';

enum MapThemeStyle {
  light,
  dark,
}

class GeoBlocState {
  final RoutePositionModel? currentPosition;
  final RouteDestinationModel? currentDestination;
  final List<LatLng>? currentRoute;

  final List<RoutePositionModel>? anotherPositions;
  final Set<RouteDestinationModel>? anotherDestinations;

  final BitmapDescriptor? myPositionIcon;
  final BitmapDescriptor? busStopIcon;
  final BitmapDescriptor? shuttleIcon;

  final MapUtilsState utils;
  final Map<MapThemeStyle, String>? mapThemes;
  final MapThemeStyle currentMapTheme;

  const GeoBlocState({
    this.currentPosition,
    this.currentDestination,
    this.currentRoute = const [],
    this.anotherPositions = const [],
    this.anotherDestinations = const {},
    this.myPositionIcon,
    this.busStopIcon,
    this.shuttleIcon,
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
    RoutePositionModel? currentPosition,
    RouteDestinationModel? currentDestination,
    List<LatLng>? currentRoute,
    List<RoutePositionModel>? anotherPositions,
    Set<RouteDestinationModel>? anotherDestinations,
    BitmapDescriptor? myPositionIcon,
    BitmapDescriptor? busStopIcon,
    BitmapDescriptor? shuttleIcon,
    MapUtilsState? utils,
    Map<MapThemeStyle, String>? mapThemes,
    MapThemeStyle? currentMapTheme,
  }) {
    return GeoBlocState(
      currentPosition: currentPosition ?? this.currentPosition,
      currentDestination: currentDestination ?? this.currentDestination,
      currentRoute: currentRoute ?? this.currentRoute,
      anotherPositions: anotherPositions ?? this.anotherPositions,
      anotherDestinations: anotherDestinations ?? this.anotherDestinations,
      myPositionIcon: myPositionIcon ?? this.myPositionIcon,
      busStopIcon: busStopIcon ?? this.busStopIcon,
      shuttleIcon: shuttleIcon ?? this.shuttleIcon,
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
