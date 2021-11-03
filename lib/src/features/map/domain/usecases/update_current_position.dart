import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_position_model.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_route.dart';

class UpdateCurrentPosition implements UseCase<Either<Failure, void>, RoutePositionModel> {
  final GeoBloc bloc;
  final UpdateCurrentRoute updateRouteUsecase;

  const UpdateCurrentPosition({
    required this.bloc,
    required this.updateRouteUsecase,
  });

  @override
  Future<Either<Failure, bool>> call(RoutePositionModel routePosition) async {
    logPrint('***** UpdateCurrentPosition call(${routePosition.routeName})');
    bloc.add(GeoUpdateCurrentPosition(
      currentPosition: routePosition,
    ));

    if (bloc.state.utils.isRouteEnabled!) {
      updateRouteUsecase.call(routePosition.position);
    }

    return const Right(true);
  }
}
