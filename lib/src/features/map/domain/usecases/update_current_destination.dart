import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';

class UpdateCurrentDestination
    implements UseCase<Either<Failure, void>, RouteDestinationModel> {
  final GeoBloc bloc;

  const UpdateCurrentDestination({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(RouteDestinationModel destination) async {
    logPrint('***** UpdateCurrentDestination call(${destination.routeName})');

    bloc.add(GeoUpdateCurrentDestination(
      currentDestination: destination,
    ));

    return const Right(true);
  }
}
