import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';

class UpdateMapMode implements UseCase<void, bool> {
  final GeoBloc bloc;

  const UpdateMapMode({
    required this.bloc,
  });

  @override
  Future<void> call(bool isInit) async {
    logPrint('UpdateMapMode -> call($isInit)');
    bloc.add(GeoUpdateMapMode(isInit: isInit));
  }
}
