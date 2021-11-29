import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';

class RouteData {
  final int routeID;
  final int regionID;
  final VehicleType vehicleType;
  final String routeNumber;
  final String routeName;

  const RouteData({
    required this.routeID,
    required this.regionID,
    required this.vehicleType,
    required this.routeNumber,
    required this.routeName,
  });

  static RouteData fromJson(Map<String, dynamic> json) {
    return RouteData(
      routeID: json['idMarshrutWO'],
      regionID: json['idRegion'],
      vehicleType: VehicleType.values[json['mMUType']],
      routeNumber: json['mNumber'],
      routeName: json['marshrutName'],
    );
  }
}
