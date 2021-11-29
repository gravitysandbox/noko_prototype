import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';

class UpdateYourRoute implements UseCase<Either<Failure, void>, LatLng> {
  final GeoBloc bloc;
  final MapUtils mapUtils;

  const UpdateYourRoute({
    required this.bloc,
    required this.mapUtils,
  });

  @override
  Future<Either<Failure, bool>> call(LatLng position,
      {bool? isReversed}) async {
    logPrint(
        'UpdateYourRoute -> call(${position.latitude} - ${position.longitude})');

    if (!bloc.state.utils.isRouteEnabled!) {
      return const Left(CommonFailure('isRouteEnabled = false'));
    }

    final route = await mapUtils.loadRouteCoordinates(
      position,
      isReversed ?? bloc.state.utils.isRouteReversed!
          ? bloc.state.yourDestination!.startBusStop.busStopPosition
          : bloc.state.yourDestination!.destinationBusStop.busStopPosition,
    );

    bloc.add(GeoUpdateYourRoute(
      yourRoute: route,
    ));

    return const Right(true);
  }
}
