import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_events.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_route.dart';

class UpdateMapUtils implements UseCase<Either<Failure, void>, MapUtilsState> {
  final GeolocationBloc bloc;
  final UpdateCurrentRoute updateRouteUsecase;

  const UpdateMapUtils({
    required this.bloc,
    required this.updateRouteUsecase,
  });

  @override
  Future<Either<Failure, bool>> call(MapUtilsState utilsState) async {
    logPrint('***** UpdateMapUtils call()');
    bloc.add(GeolocationUpdateMapUtils(
      utilsState: utilsState,
    ));

    var isRouteUpdated = false;

    if (!isRouteUpdated &&
        utilsState.isRouteEnabled != null &&
        utilsState.isRouteEnabled! &&
        bloc.state.utils.isRouteEnabled! != utilsState.isRouteEnabled!) {
      updateRouteUsecase.call(bloc.state.currentPosition!);
      isRouteUpdated = true;
    }

    if (!isRouteUpdated &&
        utilsState.isRouteReversed != null &&
        bloc.state.utils.isRouteReversed! != utilsState.isRouteReversed!) {
      updateRouteUsecase.call(bloc.state.currentPosition!, isReversed: utilsState.isRouteReversed);
      isRouteUpdated = true;
    }

    return const Right(true);
  }
}
