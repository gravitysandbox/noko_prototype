import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutePositionModel {
  final String routeName;
  final LatLng position;

  const RoutePositionModel({
    required this.routeName,
    required this.position,
  });

  RoutePositionModel copyWith({String? routeName, LatLng? position}) {
    return RoutePositionModel(
      routeName: routeName ?? this.routeName,
      position: position ?? this.position,
    );
  }
}
