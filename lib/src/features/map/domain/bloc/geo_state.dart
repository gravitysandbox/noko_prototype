import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';
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
  final int? yourVehicleID;
  final VehiclePosition? yourPosition;
  final VehicleRouteDestination? yourDestination;
  final List<LatLng> yourRoute;
  final VehicleRouteData? yourCurrentData;

  final List<int> selectedVehicleIDs;
  final List<VehiclePosition> nearestPositions;
  final List<VehicleRouteDestination> anotherDestinations;
  final List<VehiclePosition> anotherPositions;

  final Map<MapIconBitmap, BitmapDescriptor>? icons;
  final MapUtilsState utils;
  final Map<MapThemeStyle, String>? mapThemes;
  final MapThemeStyle currentMapTheme;
  final bool isInit;

  const GeoBlocState({
    this.yourVehicleID,
    this.yourPosition,
    this.yourDestination,
    this.yourRoute = const [],
    this.yourCurrentData,
    this.selectedVehicleIDs = const [],
    this.nearestPositions = const [],
    this.anotherDestinations = const [],
    this.anotherPositions = const [],
    this.icons,
    this.utils = const MapUtilsState(),
    this.mapThemes = const {},
    this.currentMapTheme = MapThemeStyle.light,
    this.isInit = false,
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
    int? yourVehicleID,
    VehiclePosition? yourPosition,
    VehicleRouteDestination? yourDestination,
    List<LatLng>? yourRoute,
    VehicleRouteData? yourCurrentData,
    List<int>? selectedVehicleIDs,
    List<VehiclePosition>? nearestPositions,
    List<VehicleRouteDestination>? anotherDestinations,
    List<VehiclePosition>? anotherPositions,
    Map<MapIconBitmap, BitmapDescriptor>? icons,
    MapUtilsState? utils,
    Map<MapThemeStyle, String>? mapThemes,
    MapThemeStyle? currentMapTheme,
    bool? isInit,
  }) {
    return GeoBlocState(
      yourVehicleID: yourVehicleID ?? this.yourVehicleID,
      yourPosition: yourPosition ?? this.yourPosition,
      yourDestination: yourDestination ?? this.yourDestination,
      yourRoute: yourRoute ?? this.yourRoute,
      yourCurrentData: yourCurrentData ?? this.yourCurrentData,
      selectedVehicleIDs: selectedVehicleIDs ?? this.selectedVehicleIDs,
      nearestPositions: nearestPositions ?? this.nearestPositions,
      anotherDestinations: anotherDestinations ?? this.anotherDestinations,
      anotherPositions: anotherPositions ?? this.anotherPositions,
      icons: icons ?? this.icons,
      utils: utils != null ? this.utils.copyWith(utils) : this.utils,
      mapThemes: mapThemes ?? this.mapThemes,
      currentMapTheme: currentMapTheme ?? this.currentMapTheme,
      isInit: isInit ?? this.isInit,
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
