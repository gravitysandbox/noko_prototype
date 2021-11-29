import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';

class UpdateMapTheme
    implements UseCase<Either<Failure, void>, MapThemeStyle> {
  final GeoBloc bloc;

  const UpdateMapTheme({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(MapThemeStyle theme) async {
    logPrint('UpdateMapTheme -> call($theme)');

    if (bloc.state.currentMapTheme != theme) {
      bloc.add(GeoUpdateCurrentMapTheme(
        mapTheme: theme,
      ));
    }

    return const Right(true);
  }
}
