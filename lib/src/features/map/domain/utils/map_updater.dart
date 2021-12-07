import 'dart:async';

import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/datasources/map_remote_datasource.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_nearest_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_current_data.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_position.dart';

class MapUpdater {
  final GeoBloc bloc;
  final MapRemoteDatasource mapRemoteDatasource;
  final UpdateYourPosition updateYourPosition;
  final UpdateYourCurrentData updateYourCurrentData;
  final UpdateNearestPositions updateNearestPositions;
  final UpdateAnotherPositions updateAnotherPositions;

  MapUpdater({
    required this.bloc,
    required this.mapRemoteDatasource,
    required this.updateYourPosition,
    required this.updateYourCurrentData,
    required this.updateNearestPositions,
    required this.updateAnotherPositions,
  });

  Timer? _timer;

  void startTracking() {
    logPrint('MapUpdater -> startTracking()');

    const int instanceID = 12;
    const int regionID = 3000;
    final int yourVehicleID = bloc.state.yourVehicleID!;
    final int yourRouteID = bloc.state.yourDestination!.routeID;
    final List<int> yourBusStopIDs =
        bloc.state.yourDestination!.busStops.map((s) => s.busStopID).toList();

    final time = DateTime.now();
    final trueMonth =
        time.month.toString().length == 1 ? '0${time.month}' : '${time.month}';
    final trueDay =
        time.day.toString().length == 1 ? '0${time.day}' : '${time.day}';
    final String date = '${time.year}-$trueMonth-$trueDay';

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      /// Update your and nearest vehicles positions
      mapRemoteDatasource
          .getVehiclePosition(
              instanceID, regionID, yourVehicleID, yourRouteID, yourBusStopIDs)
          .then((response) {
        if (response == null) return;
        updateYourPosition(
            response.firstWhere((pos) => pos.vehicleID == yourVehicleID));
        updateNearestPositions(
            response.where((pos) => pos.vehicleID != yourVehicleID).toList());

        /// Update your next bus stop data
        mapRemoteDatasource
            .getVehicleRouteData(instanceID, regionID, yourVehicleID, date)
            .then((response) {
          if (response != null) {
            updateYourCurrentData.call(response);
          }
        });
      });

      if (bloc.state.selectedVehicleIDs.isEmpty) {
        return;
      }

      /// Update another vehicles positions
      mapRemoteDatasource
          .getMultipleVehiclePosition(
              instanceID, regionID, bloc.state.anotherDestinations)
          .then((response) {
        if (response == null) return;
        updateAnotherPositions.call(response);
      });
    });
  }

  void stopTracking() {
    logPrint('MapUpdater -> stopTracking()');
    _timer?.cancel();
  }
}
