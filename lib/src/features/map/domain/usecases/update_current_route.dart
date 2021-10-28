import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/events/geolocation_events.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';

class UpdateCurrentRoute implements UseCase<Either<Failure, void>, LatLng> {
  final GeolocationBloc bloc;
  final MapUtils mapUtils;

  UpdateCurrentRoute({
    required this.bloc,
    required this.mapUtils,
  });

  @override
  Future<Either<Failure, bool>> call(LatLng position, {bool? isReversed}) async {
    logPrint('***** UpdateCurrentRoute call()');

    final destination = isReversed ?? bloc.state.utils.isRouteReversed!
        ? bloc.state.routesPositions!.first.startPosition
        : bloc.state.routesPositions!.first.destinationPosition;
    final route = await mapUtils.loadRouteCoordinates(
      position,
      destination,
    );

    if (bloc.state.utils.isRouteEnabled!) {
      bloc.add(GeolocationUpdateCurrentRoute(
        routeCoordinates: route,
      ));
    }

    return const Right(true);
  }
}
