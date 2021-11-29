import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_route.dart';

class UpdateMapUtils implements UseCase<Either<Failure, void>, MapUtilsState> {
  final GeoBloc bloc;
  final UpdateYourRoute updateRouteUsecase;

  const UpdateMapUtils({
    required this.bloc,
    required this.updateRouteUsecase,
  });

  @override
  Future<Either<Failure, bool>> call(MapUtilsState utilsState) async {
    logPrint('UpdateMapUtils -> call()');
    bloc.add(GeoUpdateMapUtils(
      utilsState: utilsState,
    ));

    var isRouteUpdated = false;

    if (!isRouteUpdated &&
        utilsState.isRouteEnabled != null &&
        utilsState.isRouteEnabled! &&
        bloc.state.utils.isRouteEnabled! != utilsState.isRouteEnabled!) {
      updateRouteUsecase.call(bloc.state.yourPosition!.position);
      isRouteUpdated = true;
    }

    if (!isRouteUpdated &&
        utilsState.isRouteReversed != null &&
        bloc.state.utils.isRouteReversed! != utilsState.isRouteReversed!) {
      updateRouteUsecase.call(bloc.state.yourPosition!.position, isReversed: utilsState.isRouteReversed);
      isRouteUpdated = true;
    }

    return const Right(true);
  }
}
