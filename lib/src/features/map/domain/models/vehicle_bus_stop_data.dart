import 'package:google_maps_flutter/google_maps_flutter.dart';

class VehicleBusStopData {
  final int busStopID;
  final String busStopName;
  final LatLng busStopPosition;
  final bool? isForwardDirection;

  const VehicleBusStopData({
    required this.busStopID,
    required this.busStopName,
    required this.busStopPosition,
    required this.isForwardDirection,
  });

  static VehicleBusStopData fromJson(Map<String, dynamic> json) {
    final isForward = json['direction'] == 10
        ? true
        : json['direction'] == 11
        ? false
        : null;

    final lat = (json['latLng'] as Map<String, dynamic>)['lat'];
    final lng = (json['latLng'] as Map<String, dynamic>)['lon'];

    return VehicleBusStopData(
      busStopID: json['stopId'],
      busStopName: json['stopName'],
      busStopPosition: LatLng(lat, lng),
      isForwardDirection: isForward,
    );
  }
}