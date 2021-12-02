import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';

class UpdateYourVehicle
    implements UseCase<Either<Failure, void>, int> {
  final GeoBloc bloc;

  const UpdateYourVehicle({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(int vehicleID) async {
    logPrint('UpdateYourVehicle -> call($vehicleID)');
    bloc.add(GeoUpdateYourVehicle(
      yourVehicleID: vehicleID,
    ));

    return const Right(true);
  }
}
