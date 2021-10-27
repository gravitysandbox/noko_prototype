import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocationState {
  final LatLng? currentPosition;
  final List<LatLng>? routePolylines;
  final Map<String, LatLng> busStopPositions;

  final BitmapDescriptor? myPositionIcon;
  final BitmapDescriptor? busStopIcon;
  final BitmapDescriptor? shuttleIcon;

  final MapUtilsState utils;

  const GeolocationState({
    this.currentPosition,
    this.routePolylines = const [],
    this.busStopPositions = const {},
    this.myPositionIcon,
    this.busStopIcon,
    this.shuttleIcon,
    this.utils = const MapUtilsState(
      isTrackingEnabled: false,
      isTrafficEnabled: false,
      isRouteEnabled: false,
    ),
  });

  GeolocationState update({
    LatLng? currentPosition,
    List<LatLng>? routePolylines,
    Map<String, LatLng>? busStopPositions,
    BitmapDescriptor? myPositionIcon,
    BitmapDescriptor? busStopIcon,
    BitmapDescriptor? shuttleIcon,
    MapUtilsState? utils,
  }) {
    return GeolocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      routePolylines: routePolylines ?? this.routePolylines,
      busStopPositions: busStopPositions ?? this.busStopPositions,
      myPositionIcon: myPositionIcon ?? this.myPositionIcon,
      busStopIcon: busStopIcon ?? this.busStopIcon,
      shuttleIcon: shuttleIcon ?? this.shuttleIcon,
      utils: utils != null ? this.utils.copyWith(utils) : this.utils,
    );
  }
}

class MapUtilsState {
  final bool? isTrackingEnabled;
  final bool? isTrafficEnabled;
  final bool? isRouteEnabled;

  const MapUtilsState({
    this.isTrackingEnabled,
    this.isTrafficEnabled,
    this.isRouteEnabled,
  });

  MapUtilsState copyWith(MapUtilsState newState) {
    return MapUtilsState(
      isTrackingEnabled: newState.isTrackingEnabled ?? isTrackingEnabled,
      isTrafficEnabled: newState.isTrafficEnabled ?? isTrafficEnabled,
      isRouteEnabled: newState.isRouteEnabled ?? isRouteEnabled,
    );
  }
}
