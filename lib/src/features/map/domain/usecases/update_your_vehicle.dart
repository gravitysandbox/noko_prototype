import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';

class UpdateYourVehicle
    implements UseCase<Either<Failure, void>, VehicleData> {
  final GeoBloc bloc;

  const UpdateYourVehicle({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(VehicleData vehicleData) async {
    logPrint('UpdateYourVehicle -> call(${vehicleData.vehicleID})');
    bloc.add(GeoUpdateYourVehicle(
      yourVehicle: vehicleData,
    ));

    return const Right(true);
  }
}
