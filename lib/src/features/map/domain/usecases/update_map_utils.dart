import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/events/geolocation_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/geolocation_state.dart';

class UpdateMapUtils implements UseCase<Either<Failure, void>, MapUtilsState> {
  final GeolocationBloc bloc;

  UpdateMapUtils({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(MapUtilsState utilsState) async {
    logPrint('***** UpdateMapUtils call()');
    bloc.add(GeolocationUpdateMapUtils(
      utilsState: utilsState,
    ));
    return const Right(true);
  }
}
