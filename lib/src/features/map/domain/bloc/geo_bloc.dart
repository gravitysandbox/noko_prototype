import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';

class GeoBloc extends Bloc<GeoBlocEvent, GeoBlocState> {
  GeoBloc(GeoBlocState initialState) : super(initialState);

  @override
  Stream<GeoBlocState> mapEventToState(GeoBlocEvent event) async* {
    logPrint('GeolocationBloc -> mapEventToState(): ${event.runtimeType}');
    switch (event.runtimeType) {
      case GeoUpdateYourVehicle:
        {
          var snapshot = event as GeoUpdateYourVehicle;
          yield state.copyWith(
            yourVehicleID: snapshot.yourVehicleID,
          );
          break;
        }

      case GeoUpdateYourPosition:
        {
          var snapshot = event as GeoUpdateYourPosition;
          yield state.copyWith(
            yourPosition: snapshot.yourPosition,
          );
          break;
        }

      case GeoUpdateYourDestination:
        {
          var snapshot = event as GeoUpdateYourDestination;
          yield state.copyWith(
            yourDestination: snapshot.yourDestination,
          );
          break;
        }

      case GeoUpdateYourRoute:
        {
          var snapshot = event as GeoUpdateYourRoute;
          yield state.copyWith(
            yourRoute: snapshot.yourRoute,
          );
          break;
        }

      case GeoUpdateYourCurrentData:
        {
          var snapshot = event as GeoUpdateYourCurrentData;
          yield state.copyWith(
            yourCurrentData: snapshot.yourData,
          );
          break;
        }

      case GeoUpdateSelectedVehicles:
        {
          var snapshot = event as GeoUpdateSelectedVehicles;
          yield state.copyWith(
            selectedVehicleIDs: snapshot.vehicles,
          );
          break;
        }

      case GeoUpdateNearestPositions:
        {
          var snapshot = event as GeoUpdateNearestPositions;
          yield state.copyWith(
            nearestPositions: snapshot.nearestPositions,
          );
          break;
        }

      case GeoUpdateAnotherDestinations:
        {
          var snapshot = event as GeoUpdateAnotherDestinations;
          yield state.copyWith(
            anotherDestinations: snapshot.anotherDestinations,
          );
          break;
        }

      case GeoUpdateAnotherPositions:
        {
          var snapshot = event as GeoUpdateAnotherPositions;
          yield state.copyWith(
            anotherPositions: snapshot.anotherPositions,
          );
          break;
        }

      case GeoUpdateIcons:
        {
          var snapshot = event as GeoUpdateIcons;
          yield state.copyWith(
            icons: snapshot.icons,
          );
          break;
        }

      case GeoUpdateMapUtils:
        {
          var snapshot = event as GeoUpdateMapUtils;
          yield state.copyWith(
            utils: snapshot.utilsState,
          );
          break;
        }

      case GeoInitMapThemes:
        {
          var snapshot = event as GeoInitMapThemes;
          yield state.copyWith(
            mapThemes: snapshot.mapThemes,
          );
          break;
        }

      case GeoUpdateCurrentMapTheme:
        {
          var snapshot = event as GeoUpdateCurrentMapTheme;
          yield state.copyWith(
            currentMapTheme: snapshot.mapTheme,
          );
          break;
        }

      case GeoUpdateMapMode:
        {
          var snapshot = event as GeoUpdateMapMode;
          yield state.copyWith(
            isInit: snapshot.isInit,
          );
          break;
        }
    }
  }
}
