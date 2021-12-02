import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';

class UpdateAllVehicles
    implements UseCase<Either<Failure, void>, List<VehicleData>> {
  final GarageBloc bloc;

  const UpdateAllVehicles({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(List<VehicleData> vehicles) async {
    logPrint('UpdateAllVehicles -> call(${vehicles.length})');
    bloc.add(GarageUpdateAllVehicles(
      vehicles: vehicles,
    ));

    return const Right(true);
  }
}
