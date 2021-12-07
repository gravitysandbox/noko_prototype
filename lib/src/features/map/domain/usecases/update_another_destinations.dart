import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_positions.dart';

class UpdateAnotherDestinations
    implements UseCase<Either<Failure, void>, List<VehicleRouteDestination>> {
  final GeoBloc bloc;
  final UpdateAnotherPositions updateAnotherPositions;

  const UpdateAnotherDestinations({
    required this.bloc,
    required this.updateAnotherPositions,
  });

  @override
  Future<Either<Failure, bool>> call(List<VehicleRouteDestination> destinations) async {
    logPrint('UpdateAnotherDestinations -> call(${destinations.length})');

    bloc.add(GeoUpdateAnotherDestinations(
      anotherDestinations: destinations,
    ));

    if (destinations.isEmpty) {
      updateAnotherPositions.call([]);
    }

    return const Right(true);
  }
}
