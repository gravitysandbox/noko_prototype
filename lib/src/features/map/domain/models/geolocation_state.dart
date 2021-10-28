import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';

class GeolocationState {
  final LatLng? currentPosition;
  final Set<RouteDestinationModel>? routesPositions;
  final Map<String, LatLng> busStopPositions;
  final List<LatLng>? currentRoute;

  final BitmapDescriptor? myPositionIcon;
  final BitmapDescriptor? busStopIcon;
  final BitmapDescriptor? shuttleIcon;

  final MapUtilsState utils;

  const GeolocationState({
    this.currentPosition,
    this.routesPositions = const {},
    this.busStopPositions = const {},
    this.currentRoute = const [],
    this.myPositionIcon,
    this.busStopIcon,
    this.shuttleIcon,
    this.utils = const MapUtilsState(
      isTrackingEnabled: false,
      isTrafficEnabled: false,
      isRouteEnabled: false,
      isRouteReversed: false,
    ),
  });

  GeolocationState update({
    LatLng? currentPosition,
    Set<RouteDestinationModel>? routesPositions,
    Map<String, LatLng>? busStopPositions,
    List<LatLng>? currentRoute,
    BitmapDescriptor? myPositionIcon,
    BitmapDescriptor? busStopIcon,
    BitmapDescriptor? shuttleIcon,
    MapUtilsState? utils,
  }) {
    return GeolocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      routesPositions: routesPositions ?? this.routesPositions,
      busStopPositions: busStopPositions ?? this.busStopPositions,
      currentRoute: currentRoute ?? this.currentRoute,
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
