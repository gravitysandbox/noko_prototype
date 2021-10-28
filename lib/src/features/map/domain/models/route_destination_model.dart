import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDestinationModel {
  final String routeName;
  final LatLng startPosition;
  final LatLng destinationPosition;

  const RouteDestinationModel({
    required this.routeName,
    required this.startPosition,
    required this.destinationPosition,
  });
}
