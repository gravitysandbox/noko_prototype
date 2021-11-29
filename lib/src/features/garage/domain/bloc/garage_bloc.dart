import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_events.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_state.dart';

class GarageBloc extends Bloc<GarageBlocEvent, GarageBlocState> {
  GarageBloc(GarageBlocState initialState) : super(initialState);

  @override
  Stream<GarageBlocState> mapEventToState(
      GarageBlocEvent event) async* {
    logPrint('GarageBloc -> mapEventToState(): ${event.runtimeType}');
    switch (event.runtimeType) {
      case GarageUpdateTest:
        {
          var snapshot = event as GarageUpdateTest;
          yield state.copyWith(
            test: snapshot.test,
          );
          break;
        }
    }
  }
}
