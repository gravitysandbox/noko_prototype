import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_current_position.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_destinations.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/utils/mock_geo_service.dart';

class InitGoogleMap implements UseCase<Either<Failure, void>, BuildContext> {
  final GeoBloc bloc;
  final MapUtils mapUtils;
  final MockGeoService mockGeoService;

  final UpdateCurrentPosition updateCurrentPosition;
  final UpdateCurrentDestination updateCurrentDestination;
  final UpdateAnotherPositions updateAnotherPositions;
  final UpdateAnotherDestinations updateAnotherDestinations;

  const InitGoogleMap({
    required this.bloc,
    required this.mapUtils,
    required this.mockGeoService,
    required this.updateCurrentPosition,
    required this.updateCurrentDestination,
    required this.updateAnotherPositions,
    required this.updateAnotherDestinations,
  });

  @override
  Future<Either<Failure, bool>> call(BuildContext context) async {
    logPrint('***** InitGoogleMap call()');
    BitmapDescriptor myPositionIcon = await mapUtils.loadMarkerImageFromAsset(
        context, 'assets/icons/ic_my_transport.png');
    BitmapDescriptor busStopIcon = await mapUtils.loadMarkerImageFromAsset(
        context, 'assets/icons/ic_bus_stop.png');
    BitmapDescriptor shuttleIcon = await mapUtils.loadMarkerImageFromAsset(
        context, 'assets/icons/ic_shuttle_route_white.png');

    /// Set icons
    bloc.add(GeoUpdateIcons(
      myPositionIcon: myPositionIcon,
      busStopIcon: busStopIcon,
      shuttleIcon: shuttleIcon,
    ));

    /// Set map themes
    String lightMapTheme =
        await rootBundle.loadString('assets/map_styles/light.json');
    String darkMapTheme =
        await rootBundle.loadString('assets/map_styles/dark.json');
    bloc.add(GeoInitMapThemes(mapThemes: {
      MapThemeStyle.light: lightMapTheme,
      MapThemeStyle.dark: darkMapTheme,
    }));

    /// Set current & another positions and destination points
    GeoBlocState initialState = mockGeoService.initialGeoData();
    updateCurrentPosition(initialState.currentPosition!);
    updateCurrentDestination(initialState.currentDestination!);

    updateAnotherPositions(initialState.anotherPositions!);
    updateAnotherDestinations(initialState.anotherDestinations!);

    /// Start geolocation mock service
    mockGeoService.startTracking();

    return const Right(true);
  }
}
