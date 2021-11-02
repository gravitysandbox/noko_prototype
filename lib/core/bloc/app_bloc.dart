import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/bloc/app_events.dart';
import 'package:noko_prototype/core/bloc/app_state.dart';
import 'package:noko_prototype/core/utils/logger.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBloc(AppBlocState initialState) : super(initialState);

  @override
  Stream<AppBlocState> mapEventToState(AppBlocEvent event) async* {
    logPrint('***** AppBloc mapEventToState(): ${event.runtimeType}');
    switch (event.runtimeType) {
      case AppUpdateTheme:
        {
          var snapshot = event as AppUpdateTheme;
          yield state.update(
            isDarkTheme: snapshot.isDarkTheme,
          );
          break;
        }
    }
  }
}
