import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';

class UpdateYourDestination
    implements UseCase<Either<Failure, void>, VehicleRouteDestination> {
  final GeoBloc bloc;

  const UpdateYourDestination({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(VehicleRouteDestination destination) async {
    logPrint('UpdateYourDestination -> call(${destination.routeName})');

    bloc.add(GeoUpdateYourDestination(
      yourDestination: destination,
    ));

    return const Right(true);
  }
}
