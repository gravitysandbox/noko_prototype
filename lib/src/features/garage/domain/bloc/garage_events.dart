import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_schedule_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_timetable_data.dart';

abstract class GarageBlocEvent {
  const GarageBlocEvent([List props = const []]) : super();
}

class GarageUpdateAllVehicles extends GarageBlocEvent {
  final List<VehicleData> vehicles;

  GarageUpdateAllVehicles({
    required this.vehicles,
  }) : super([vehicles]);
}

class GarageUpdateAllSchedules extends GarageBlocEvent {
  final List<VehicleFullScheduleData?> schedules;

  GarageUpdateAllSchedules({
    required this.schedules,
  }) : super([schedules]);
}

class GarageUpdateAllTimetables extends GarageBlocEvent {
  final List<VehicleTimetableData?> timetables;

  GarageUpdateAllTimetables({
    required this.timetables,
  }) : super([timetables]);
}
