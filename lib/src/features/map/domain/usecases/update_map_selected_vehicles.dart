import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_destinations.dart';

class UpdateMapSelectedVehicles
    implements UseCase<Either<Failure, void>, VehicleData> {
  final GeoBloc geoBloc;
  final GarageBloc garageBloc;
  final UpdateAnotherDestinations updateAnotherDestinations;

  const UpdateMapSelectedVehicles({
    required this.geoBloc,
    required this.garageBloc,
    required this.updateAnotherDestinations,
  });

  @override
  Future<Either<Failure, bool>> call(VehicleData vehicle) async {
    logPrint('UpdateMapSelectedVehicles -> call(${vehicle.vehicleID})');
    final selectedVehicles = [...geoBloc.state.selectedVehicleIDs];
    VehicleRouteDestination? destination;

    if (selectedVehicles.contains(vehicle.vehicleID)) {
      selectedVehicles.remove(vehicle.vehicleID);
    } else {
      selectedVehicles.add(vehicle.vehicleID);
      var vehicleIndex = garageBloc.state.vehicles.indexOf(vehicle);
      var routeID =
          garageBloc.state.timetables[vehicleIndex]!.timetable[0].routeID;
      var busStops = garageBloc.state.busStops[vehicleIndex] ?? [];

      destination = VehicleRouteDestination(
        vehicleID: vehicle.vehicleID,
        routeID: routeID,
        startBusStop: busStops.first,
        destinationBusStop: busStops.last,
        busStops: busStops,
      );
    }

    geoBloc.add(GeoUpdateSelectedVehicles(
      vehicles: selectedVehicles,
    ));

    if (destination == null) {
      updateAnotherDestinations.call(geoBloc.state.anotherDestinations
          .where((des) => des.vehicleID != vehicle.vehicleID)
          .toList());
    } else {
      updateAnotherDestinations
          .call([...geoBloc.state.anotherDestinations, destination]);
    }

    return const Right(true);
  }
}
