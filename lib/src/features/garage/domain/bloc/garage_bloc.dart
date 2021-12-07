import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_events.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_state.dart';

class GarageBloc extends Bloc<GarageBlocEvent, GarageBlocState> {
  GarageBloc(GarageBlocState initialState) : super(initialState);

  @override
  Stream<GarageBlocState> mapEventToState(GarageBlocEvent event) async* {
    logPrint('GarageBloc -> mapEventToState(): ${event.runtimeType}');
    switch (event.runtimeType) {
      case GarageUpdateAllVehicles:
        {
          var snapshot = event as GarageUpdateAllVehicles;
          yield state.copyWith(
            vehicles: snapshot.vehicles,
          );
          break;
        }

      case GarageUpdateAllSchedules:
        {
          var snapshot = event as GarageUpdateAllSchedules;
          yield state.copyWith(
            schedules: snapshot.schedules,
          );
          break;
        }

      case GarageUpdateAllTimetables:
        {
          var snapshot = event as GarageUpdateAllTimetables;
          yield state.copyWith(
            timetables: snapshot.timetables,
          );
          break;
        }

      case GarageUpdateAllBusStops:
        {
          var snapshot = event as GarageUpdateAllBusStops;
          yield state.copyWith(
            busStops: snapshot.busStops,
          );
          break;
        }
    }
  }
}
