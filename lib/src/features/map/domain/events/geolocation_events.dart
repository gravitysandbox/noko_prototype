import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/models/geolocation_state.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent([List props = const []]) : super();
}

class GeolocationUpdateIcons extends GeolocationEvent {
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

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GeolocationUpdatePosition extends GeolocationEvent {
  final LatLng currentPosition;

  GeolocationUpdatePosition({
    required this.currentPosition,
  }) : super([currentPosition]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GeolocationUpdateMarkers extends GeolocationEvent {
  final Map<String, LatLng> markersCoordinates;

  GeolocationUpdateMarkers({
    required this.markersCoordinates,
  }) : super([markersCoordinates]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GeolocationUpdatePolylines extends GeolocationEvent {
  final List<LatLng> polylinesCoordinates;

  GeolocationUpdatePolylines({
    required this.polylinesCoordinates,
  }) : super([polylinesCoordinates]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GeolocationUpdateMapUtils extends GeolocationEvent {
  final MapUtilsState utilsState;

  GeolocationUpdateMapUtils({
    required this.utilsState,
  }) : super([utilsState]);

  @override
  List<Object?> get props => throw UnimplementedError();
}
