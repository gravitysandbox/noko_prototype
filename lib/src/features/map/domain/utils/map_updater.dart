import 'dart:async';

import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/datasources/map_remote_datasource.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_position.dart';

class MapUpdater {
  final GeoBloc bloc;
  final MapRemoteDatasource mapRemoteDatasource;
  final UpdateYourPosition updateCurrentPosition;
  final UpdateAnotherPositions updateAnotherPositions;

  MapUpdater({
    required this.bloc,
    required this.mapRemoteDatasource,
    required this.updateCurrentPosition,
    required this.updateAnotherPositions,
  });

  Timer? _timer;

  void startTracking() {
    logPrint('MapUpdater -> startTracking()');

    const int instantID = 12;
    final int regionID = bloc.state.yourVehicle!.regionID;
    final int vehicleID = bloc.state.yourVehicle!.vehicleID;
    final int routeID = bloc.state.yourDestination!.routeID;
    final List<int> busStopIDs = bloc.state.yourDestination!.busStops
        .map((s) => s.busStopID)
        .toList();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      mapRemoteDatasource
          .getVehiclePosition(
              instantID, regionID, vehicleID, routeID, busStopIDs)
          .then((response) {
        if (response == null) return;
        updateCurrentPosition(response.firstWhere((pos) => pos.vehicleID == vehicleID));
        updateAnotherPositions(response.where((pos) => pos.vehicleID != vehicleID).toList());
      });
    });
  }

  void stopTracking() {
    logPrint('MapUpdater -> stopTracking()');
    if (_timer != null) _timer!.cancel();
  }
}
