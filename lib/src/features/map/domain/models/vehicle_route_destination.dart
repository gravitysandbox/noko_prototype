import 'package:noko_prototype/src/features/map/domain/models/vehicle_bus_stop_data.dart';

class VehicleRouteDestination {
  final int vehicleID;
  final int routeID;
  final VehicleBusStopData startBusStop;
  final VehicleBusStopData destinationBusStop;
  final List<VehicleBusStopData> busStops;

  const VehicleRouteDestination({
    required this.vehicleID,
    required this.routeID,
    required this.startBusStop,
    required this.destinationBusStop,
    required this.busStops,
  });
}
