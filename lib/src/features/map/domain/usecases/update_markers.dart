import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/events/geolocation_events.dart';

class UpdateMarkers
    implements UseCase<Either<Failure, void>, Map<String, LatLng>> {
  final GeolocationBloc bloc;

  UpdateMarkers({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(Map<String, LatLng> coordinates) async {
    logPrint('***** UpdateMarkers call()');
    bloc.add(GeolocationUpdateMarkers(
      markersCoordinates: coordinates,
    ));
    return const Right(true);
  }
}
