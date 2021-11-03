import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_position_model.dart';

class UpdateAnotherPositions
    implements UseCase<Either<Failure, void>, List<RoutePositionModel>> {
  final GeoBloc bloc;

  const UpdateAnotherPositions({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(List<RoutePositionModel> positions) async {
    logPrint('***** UpdateAnotherPositions call(${positions.length})');

    bloc.add(GeoUpdateAnotherPositions(
      anotherPositions: positions,
    ));

    return const Right(true);
  }
}
