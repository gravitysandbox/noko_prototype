import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_bus_stop_data.dart';

class UpdateAllBusStops
    implements UseCase<Either<Failure, void>, List<List<VehicleBusStopData>?>> {
  final GarageBloc bloc;

  const UpdateAllBusStops({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(
      List<List<VehicleBusStopData>?> busStops) async {
    logPrint('UpdateAllBusStops -> call(${busStops.length})');
    bloc.add(GarageUpdateAllBusStops(
      busStops: busStops,
    ));

    return const Right(true);
  }
}
