import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';

class UpdateAnotherDestinations
    implements UseCase<Either<Failure, void>, Set<RouteDestinationModel>> {
  final GeoBloc bloc;

  const UpdateAnotherDestinations({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(Set<RouteDestinationModel> destinations) async {
    logPrint('***** UpdateAnotherDestinations call(${destinations.length})');

    bloc.add(GeoUpdateAnotherDestinations(
      anotherDestinations: destinations,
    ));

    return const Right(true);
  }
}
