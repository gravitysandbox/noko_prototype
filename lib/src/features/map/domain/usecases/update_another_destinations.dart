import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';

class UpdateAnotherDestinations
    implements UseCase<Either<Failure, void>, List<VehicleRouteDestination>> {
  final GeoBloc bloc;

  const UpdateAnotherDestinations({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(List<VehicleRouteDestination> destinations) async {
    logPrint('UpdateAnotherDestinations -> call(${destinations.length})');

    bloc.add(GeoUpdateAnotherDestinations(
      anotherDestinations: destinations,
    ));

    return const Right(true);
  }
}
