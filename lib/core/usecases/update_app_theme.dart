import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/bloc/app_bloc.dart';
import 'package:noko_prototype/core/bloc/app_events.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_theme.dart';

class UpdateAppTheme implements UseCase<Either<Failure, void>, bool> {
  final AppBloc appBloc;
  final UpdateMapTheme updateMapTheme;

  const UpdateAppTheme({
    required this.appBloc,
    required this.updateMapTheme,
  });

  @override
  Future<Either<Failure, bool>> call(bool isDark) async {
    logPrint('***** UpdateAppTheme call($isDark)');
    if (appBloc.state.isDarkTheme != isDark) {
      appBloc.add(AppUpdateTheme(
        isDarkTheme: isDark,
      ));
      updateMapTheme.call(isDark ? MapThemeStyle.dark : MapThemeStyle.light);
    }

    return const Right(true);
  }
}
