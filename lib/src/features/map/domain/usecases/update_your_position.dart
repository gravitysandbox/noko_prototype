import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_position.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_route.dart';

class UpdateYourPosition
    implements UseCase<Either<Failure, void>, VehiclePosition> {
  final GeoBloc bloc;
  final UpdateYourRoute updateRouteUsecase;

  const UpdateYourPosition({
    required this.bloc,
    required this.updateRouteUsecase,
  });

  @override
  Future<Either<Failure, bool>> call(VehiclePosition vehiclePosition) async {
    logPrint('UpdateYourPosition -> call(${vehiclePosition.routeNumber})');
    bloc.add(GeoUpdateYourPosition(
      yourPosition: vehiclePosition,
    ));

    if (bloc.state.utils.isRouteEnabled!) {
      updateRouteUsecase.call(vehiclePosition.position);
    }

    return const Right(true);
  }
}
