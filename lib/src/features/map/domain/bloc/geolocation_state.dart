import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';

enum MapThemeStyle {
  light,
  dark,
}

class GeolocationBlocState {
  final LatLng? currentPosition;
  final Set<RouteDestinationModel>? routesPositions;
  final Map<String, LatLng> busStopPositions;
  final List<LatLng>? currentRoute;

  final BitmapDescriptor? myPositionIcon;
  final BitmapDescriptor? busStopIcon;
  final BitmapDescriptor? shuttleIcon;

  final MapUtilsState utils;
  final Map<MapThemeStyle, String>? mapThemes;
  final MapThemeStyle currentMapTheme;

  const GeolocationBlocState({
    this.currentPosition,
    required this.routesPositions,
    required this.busStopPositions,
    this.currentRoute = const [],
    this.myPositionIcon,
    this.busStopIcon,
    this.shuttleIcon,
    this.utils = const MapUtilsState(),
    this.mapThemes = const {},
    this.currentMapTheme = MapThemeStyle.light,
  });

  factory GeolocationBlocState.initial() {
    return const GeolocationBlocState(
      routesPositions: {},
      busStopPositions: {},
      utils: MapUtilsState(
        isTrackingEnabled: false,
        isTrafficEnabled: false,
        isRouteEnabled: false,
        isRouteReversed: false,
      ),
      currentMapTheme: MapThemeStyle.light,
    );
  }

  GeolocationBlocState update({
    LatLng? currentPosition,
    Set<RouteDestinationModel>? routesPositions,
    Map<String, LatLng>? busStopPositions,
    List<LatLng>? currentRoute,
    BitmapDescriptor? myPositionIcon,
    BitmapDescriptor? busStopIcon,
    BitmapDescriptor? shuttleIcon,
    MapUtilsState? utils,
    Map<MapThemeStyle, String>? mapThemes,
    MapThemeStyle? currentMapTheme,
  }) {
    return GeolocationBlocState(
      currentPosition: currentPosition ?? this.currentPosition,
      routesPositions: routesPositions ?? this.routesPositions,
      busStopPositions: busStopPositions ?? this.busStopPositions,
      currentRoute: currentRoute ?? this.currentRoute,
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
