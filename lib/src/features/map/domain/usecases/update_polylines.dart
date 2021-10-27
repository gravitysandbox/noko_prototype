import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/events/geolocation_events.dart';

class UpdatePolylines
    implements UseCase<Either<Failure, void>, List<LatLng>> {
  final GeolocationBloc bloc;

  UpdatePolylines({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(List<LatLng> coordinates) async {
    logPrint('***** UpdatePolylines call()');
    bloc.add(GeolocationUpdatePolylines(
      polylinesCoordinates: coordinates,
    ));
    return const Right(true);
  }
}
