import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/domain/datasources/garage_remote_datasource.dart';
import 'package:noko_prototype/src/features/garage/domain/usecases/update_all_bus_stops.dart';
import 'package:noko_prototype/src/features/garage/domain/usecases/update_all_schedules.dart';
import 'package:noko_prototype/src/features/garage/domain/usecases/update_all_timetables.dart';
import 'package:noko_prototype/src/features/garage/domain/usecases/update_all_vehicles.dart';
import 'package:noko_prototype/src/features/map/domain/datasources/map_remote_datasource.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_bus_stop_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_schedule_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_timetable_data.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_vehicle.dart';

class InitGarageScreen implements UseCase<Either<Failure, void>, NoParams> {
  final GarageBloc bloc;
  final GarageRemoteDatasource garageRemoteDatasource;
  final MapRemoteDatasource mapRemoteDatasource;

  final UpdateAllVehicles updateAllVehicles;
  final UpdateAllSchedules updateAllSchedules;
  final UpdateAllTimetables updateAllTimetables;
  final UpdateAllBusStops updateAllBusStops;
  final UpdateYourVehicle updateYourVehicle;

  const InitGarageScreen({
    required this.bloc,
    required this.garageRemoteDatasource,
    required this.mapRemoteDatasource,
    required this.updateAllSchedules,
    required this.updateAllVehicles,
    required this.updateAllTimetables,
    required this.updateAllBusStops,
    required this.updateYourVehicle,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    logPrint('InitGarageScreen -> call()');

    /// Service data
    const int instantID = 12;
    const int regionID = 3000;

    final time = DateTime.now();
    final trueMonth = time.month.toString().length == 1 ? '0${time.month}' : '${time.month}';
    final trueDay = time.day.toString().length == 1 ? '0${time.day}' : '${time.day}';
    final String date = '${time.year}-$trueMonth-$trueDay';

    /// Get all vehicles in region
    final vehicles =
        await garageRemoteDatasource.getRegionVehicles(instantID, regionID);
    if (vehicles == null || vehicles.isEmpty) {
      logPrint('Vehicles is empty');
      return const Left(CommonFailure('Vehicles is empty'));
    }

    final sortedVehicles = vehicles.getRange(0, 50).toList();
    final sortedSchedule = <VehicleFullScheduleData?>[];
    final sortedTimetable = <VehicleTimetableData?>[];
    final sortedBusStops = <List<VehicleBusStopData>?>[];

    var amount = sortedVehicles.length;
    var counter = 0;

    sortedVehicles.forEach((vehicle) async {
      /// Get vehicle schedule to check whether it is active or not
      final scheduleResult = await garageRemoteDatasource.getVehicleFullSchedule(
        instantID,
        vehicle.vehicleID,
        date,
      );

      if (scheduleResult == null ||
          !scheduleResult.finalTime.isAfter(DateTime.now())) {
        sortedSchedule.add(null);
        sortedTimetable.add(null);
        sortedBusStops.add(null);
        counter++;
        return;
      }

      /// Get vehicle route data
      final timetableResult = await garageRemoteDatasource.getVehicleTimetable(
        instantID,
        regionID,
        vehicle.vehicleID,
        date,
      );

      if (timetableResult == null || timetableResult.timetable.isEmpty) {
        sortedSchedule.add(scheduleResult);
        sortedTimetable.add(null);
        sortedBusStops.add(null);
        counter++;
        return;
      }

      /// Get vehicle bus stop positions
      final busStopsResult = await mapRemoteDatasource.getVehicleBusStops(
        instantID,
        vehicle.vehicleID,
      );

      if (busStopsResult == null || busStopsResult.isEmpty) {
        sortedSchedule.add(scheduleResult);
        sortedTimetable.add(timetableResult);
        sortedBusStops.add(null);
        counter++;
        return;
      }

      sortedSchedule.add(scheduleResult);
      sortedTimetable.add(timetableResult);
      sortedBusStops.add(busStopsResult);
      counter++;
    });

    while (counter != amount) {
      await Future.delayed(const Duration(seconds: 1));
    }

    updateAllVehicles.call(sortedVehicles);
    updateAllSchedules.call(sortedSchedule);
    updateAllTimetables.call(sortedTimetable);
    updateAllBusStops.call(sortedBusStops);

    final activeVehicles = sortedVehicles.where((vehicle) {
      var index = sortedVehicles.indexOf(vehicle);
      return sortedSchedule[index] != null && sortedTimetable[index] != null && sortedBusStops[index] != null;
    }).toList();

    if (activeVehicles.isEmpty) {
      return const Left(CommonFailure('NO ACTIVE VEHICLES'));
    }

    updateYourVehicle.call(activeVehicles[0].vehicleID);
    return const Right(true);
  }
}
