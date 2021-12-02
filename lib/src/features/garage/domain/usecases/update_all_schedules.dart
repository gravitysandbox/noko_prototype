import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_schedule_data.dart';

class UpdateAllSchedules
    implements UseCase<Either<Failure, void>, List<VehicleFullScheduleData?>> {
  final GarageBloc bloc;

  const UpdateAllSchedules({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(
      List<VehicleFullScheduleData?> schedules) async {
    logPrint('UpdateAllSchedules -> call(${schedules.length})');
    bloc.add(GarageUpdateAllSchedules(
      schedules: schedules,
    ));

    return const Right(true);
  }
}
