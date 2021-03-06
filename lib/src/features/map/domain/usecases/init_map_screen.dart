import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/garage/domain/bloc/garage_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_state.dart';
import 'package:noko_prototype/src/features/map/domain/datasources/map_remote_datasource.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_position.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_destinations.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_map_mode.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_nearest_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_current_data.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_position.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';

class InitMapScreen implements UseCase<Either<Failure, void>, BuildContext> {
  final GeoBloc geoBloc;
  final GarageBloc garageBloc;

  final MapUtils mapUtils;
  final MapRemoteDatasource mapRemoteDatasource;

  final UpdateYourPosition updateYourPosition;
  final UpdateYourDestination updateYourDestination;
  final UpdateYourCurrentData updateYourCurrentData;

  final UpdateNearestPositions updateNearestPositions;
  final UpdateAnotherDestinations updateAnotherDestinations;
  final UpdateAnotherPositions updateAnotherPositions;
  final UpdateMapMode updateMapMode;

  const InitMapScreen({
    required this.geoBloc,
    required this.garageBloc,
    required this.mapUtils,
    required this.mapRemoteDatasource,
    required this.updateYourPosition,
    required this.updateYourDestination,
    required this.updateYourCurrentData,
    required this.updateNearestPositions,
    required this.updateAnotherDestinations,
    required this.updateAnotherPositions,
    required this.updateMapMode,
  });

  @override
  Future<Either<Failure, bool>> call(BuildContext context) async {
    logPrint('InitMapScreen -> call()');
    BitmapDescriptor yourPositionIcon = await mapUtils.loadMarkerImageFromAsset(
        context,
        Platform.isAndroid
            ? 'assets/icons/ic_my_transport.png'
            : 'assets/icons/ic_my_transport_small.png');
    BitmapDescriptor busStopIcon = await mapUtils.loadMarkerImageFromAsset(
        context,
        Platform.isAndroid
            ? 'assets/icons/ic_bus_stop.png'
            : 'assets/icons/ic_bus_stop_small.png');

    /// Set icons
    geoBloc.add(GeoUpdateIcons(
      icons: {
        MapIconBitmap.you: yourPositionIcon,
        MapIconBitmap.another: yourPositionIcon,
        MapIconBitmap.busStop: busStopIcon,
      },
    ));

    /// Set map themes
    String lightMapTheme =
        await rootBundle.loadString('assets/map_styles/light.json');
    String darkMapTheme =
        await rootBundle.loadString('assets/map_styles/dark.json');
    geoBloc.add(GeoInitMapThemes(mapThemes: {
      MapThemeStyle.light: lightMapTheme,
      MapThemeStyle.dark: darkMapTheme,
    }));

    /// Service data
    const int instantID = 12;
    const int regionID = 3000;

    final time = DateTime.now();
    final trueMonth = time.month.toString().length == 1 ? '0${time.month}' : '${time.month}';
    final trueDay = time.day.toString().length == 1 ? '0${time.day}' : '${time.day}';
    final String date = '${time.year}-$trueMonth-$trueDay';

    final vehicles = garageBloc.state.vehicles;
    if (vehicles.isEmpty) {
      return const Left(CommonFailure('Vehicles is empty'));
    }

    final selectedVehicles = vehicles
        .where((vehicle) =>
            vehicle.vehicleID == geoBloc.state.yourVehicleID ||
            geoBloc.state.selectedVehicleIDs.contains(vehicle.vehicleID))
        .toList();
    final anotherDestinations = <VehicleRouteDestination>[];
    final anotherPositions = <VehiclePosition>[];

    var amount = selectedVehicles.length;
    var counter = 0;

    selectedVehicles.forEach((vehicle) async {
      /// Get vehicle bus stops
      final vehicleIndex = garageBloc.state.vehicles.indexOf(vehicle);
      final busStops = await mapRemoteDatasource.getVehicleBusStops(
        instantID,
        vehicle.vehicleID,
      );

      if (busStops == null || busStops.isEmpty) {
        counter++;
        return;
      }

      var routeID =
          garageBloc.state.timetables[vehicleIndex]!.timetable[0].routeID;

      /// Get all vehicles in the route
      var positions = await mapRemoteDatasource.getVehiclePosition(
        instantID,
        regionID,
        vehicle.vehicleID,
        routeID,
        busStops.map((s) => s.busStopID).toList(),
      );

      if (positions == null) {
        counter++;
        return;
      }

      if (vehicle.vehicleID == geoBloc.state.yourVehicleID) {
        updateYourDestination.call(VehicleRouteDestination(
          vehicleID: vehicle.vehicleID,
          routeID: routeID,
          startBusStop: busStops.first,
          destinationBusStop: busStops.last,
          busStops: busStops,
        ));

        updateYourPosition.call(
            positions.firstWhere((pos) => pos.vehicleID == vehicle.vehicleID));
        updateNearestPositions.call(positions
            .where((pos) => pos.vehicleID != vehicle.vehicleID)
            .toList());

        /// Get current vehicle route data
        var routeData = await mapRemoteDatasource.getVehicleRouteData(
          instantID,
          regionID,
          vehicle.vehicleID,
          date,
        );

        if (routeData != null) {
          updateYourCurrentData.call(routeData);
        }
      } else {
        anotherDestinations.add(VehicleRouteDestination(
          vehicleID: vehicle.vehicleID,
          routeID: routeID,
          startBusStop: busStops.first,
          destinationBusStop: busStops.last,
          busStops: busStops,
        ));
        anotherPositions.addAll(positions);
      }

      counter++;
    });

    while (counter != amount) {
      await Future.delayed(const Duration(seconds: 1));
    }

    if (anotherDestinations.isNotEmpty && anotherPositions.isNotEmpty) {
      updateAnotherDestinations.call(anotherDestinations);
      updateAnotherPositions.call(anotherPositions);
    }

    updateMapMode.call(true);
    return const Right(true);
  }
}
