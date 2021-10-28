import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geolocation_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/events/geolocation_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/geolocation_state.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_markers.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_position.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_routes.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';
import 'package:noko_prototype/src/features/map/domain/utils/shadow_geolocation_updater.dart';

class InitGoogleMap implements UseCase<Either<Failure, void>, BuildContext> {
  final GeolocationBloc bloc;
  final MapUtils mapUtils;
  final ShadowGeolocationUpdater geolocationUpdater;

  final UpdateMarkers updateMarkersUsecase;
  final UpdateRoutes updateRoutesUsecase;
  final UpdatePosition updatePositionUsecase;

  InitGoogleMap({
    required this.bloc,
    required this.mapUtils,
    required this.geolocationUpdater,
    required this.updateMarkersUsecase,
    required this.updateRoutesUsecase,
    required this.updatePositionUsecase,
  });

  @override
  Future<Either<Failure, bool>> call(BuildContext context) async {
    logPrint('***** InitGoogleMap call()');
    BitmapDescriptor myPositionIcon = await mapUtils.loadMarkerImageFromAsset(context, 'assets/icons/ic_my_transport.png');
    BitmapDescriptor busStopIcon = await mapUtils.loadMarkerImageFromAsset(context, 'assets/icons/ic_bus_stop.png');
    BitmapDescriptor shuttleIcon = await mapUtils.loadMarkerImageFromAsset(context, 'assets/icons/ic_shuttle_route_white.png');

    GeolocationState initialState = geolocationUpdater.initialGeoPosition();

    bloc.add(GeolocationUpdateIcons(
      myPositionIcon: myPositionIcon,
      busStopIcon: busStopIcon,
      shuttleIcon: shuttleIcon,
    ));

    updateMarkersUsecase(initialState.busStopPositions);
    updateRoutesUsecase(initialState.routesPositions!);
    updatePositionUsecase(initialState.currentPosition!);

    geolocationUpdater.startTracking();

    return const Right(true);
  }
}
