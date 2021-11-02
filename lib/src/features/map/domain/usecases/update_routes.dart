import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_destination_model.dart';

class UpdateRoutes
    implements UseCase<Either<Failure, void>, Set<RouteDestinationModel>> {
  final GeolocationBloc bloc;

  const UpdateRoutes({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(Set<RouteDestinationModel> routes) async {
    logPrint('***** UpdateRoutes call()');
    bloc.add(GeolocationUpdateRoutes(
      routesCoordinates: routes,
    ));
    return const Right(true);
  }
}
