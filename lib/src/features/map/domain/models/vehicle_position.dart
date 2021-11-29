import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';

class VehiclePosition {
  final int vehicleID;
  final String vehicleName;
  final VehicleType vehicleType;
  final LatLng position;
  final int vector;
  final String routeNumber;
  final String advanceTime;

  const VehiclePosition({
    required this.vehicleID,
    required this.vehicleName,
    required this.vehicleType,
    required this.position,
    required this.vector,
    required this.routeNumber,
    required this.advanceTime,
  });

  static VehiclePosition fromJson(Map<String, dynamic> json) {
    return VehiclePosition(
      vehicleID: json['idVehicle'],
      vehicleName: json['vName'],
      vehicleType: VehicleType.values[json['muType']],
      position: LatLng(json['lat'], json['lon']),
      vector: json['vector'],
      routeNumber: json['marshrutNumber'],
      advanceTime: json['timeTS'],
    );
  }
}
