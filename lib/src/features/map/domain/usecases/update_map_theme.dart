import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_events.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_state.dart';

class UpdateMapTheme
    implements UseCase<Either<Failure, void>, MapThemeStyle> {
  final GeolocationBloc bloc;

  const UpdateMapTheme({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(MapThemeStyle theme) async {
    logPrint('***** UpdateMapTheme call($theme)');

    if (bloc.state.currentMapTheme != theme) {
      bloc.add(GeolocationUpdateMapTheme(
        mapTheme: theme,
      ));
    }

    return const Right(true);
  }
}
