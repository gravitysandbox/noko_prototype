import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_timetable_data.dart';

class UpdateAllTimetables
    implements UseCase<Either<Failure, void>, List<VehicleTimetableData?>> {
  final GarageBloc bloc;

  const UpdateAllTimetables({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(
      List<VehicleTimetableData?> timetables) async {
    logPrint('UpdateAllTimetables -> call(${timetables.length})');
    bloc.add(GarageUpdateAllTimetables(
      timetables: timetables,
    ));

    return const Right(true);
  }
}
