import 'package:noko_prototype/src/features/map/domain/models/vehicle_bus_stop_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_schedule_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_timetable_data.dart';

class GarageBlocState {
  final List<VehicleData> vehicles;
  final List<VehicleFullScheduleData?> schedules;
  final List<VehicleTimetableData?> timetables;
  final List<List<VehicleBusStopData>?> busStops;

  const GarageBlocState({
    this.vehicles = const [],
    this.schedules = const [],
    this.timetables = const [],
    this.busStops = const [],
  });

  factory GarageBlocState.initial() {
    return const GarageBlocState();
  }

  GarageBlocState copyWith({
    List<VehicleData>? vehicles,
    List<VehicleFullScheduleData?>? schedules,
    List<VehicleTimetableData?>? timetables,
    List<List<VehicleBusStopData>?>? busStops,
  }) {
    return GarageBlocState(
      vehicles: vehicles ?? this.vehicles,
      schedules: schedules ?? this.schedules,
      timetables: timetables ?? this.timetables,
      busStops: busStops ?? this.busStops,
    );
  }
}
