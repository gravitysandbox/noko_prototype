import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_events.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_route.dart';

class UpdatePosition implements UseCase<Either<Failure, void>, LatLng> {
  final GeolocationBloc bloc;
  final UpdateCurrentRoute updateRouteUsecase;

  const UpdatePosition({
    required this.bloc,
    required this.updateRouteUsecase,
  });

  @override
  Future<Either<Failure, bool>> call(LatLng position) async {
    logPrint('***** UpdatePosition call()');
    bloc.add(GeolocationUpdatePosition(
      currentPosition: position,
    ));

    if (bloc.state.utils.isRouteEnabled!) {
      updateRouteUsecase.call(position);
    }

    return const Right(true);
  }
}
