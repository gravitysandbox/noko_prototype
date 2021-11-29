import 'package:noko_prototype/src/features/map/domain/models/vehicle_bus_stop_data.dart';

class VehicleRouteDestination {
  final int routeID;
  final String routeName;
  final VehicleBusStopData startBusStop;
  final VehicleBusStopData destinationBusStop;
  final List<VehicleBusStopData> busStops;

  const VehicleRouteDestination({
    required this.routeID,
    required this.routeName,
    required this.startBusStop,
    required this.destinationBusStop,
    required this.busStops,
  });
}
