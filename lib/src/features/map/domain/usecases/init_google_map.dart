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
import 'package:noko_prototype/src/features/map/domain/datasources/map_remote_datasource.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_bus_stop_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_position.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_another_positions.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_destination.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_position.dart';
import 'package:noko_prototype/src/features/map/domain/usecases/update_your_vehicle.dart';
import 'package:noko_prototype/src/features/map/domain/utils/map_utils.dart';

class InitGoogleMap implements UseCase<Either<Failure, void>, BuildContext> {
  final GeoBloc bloc;
  final MapUtils mapUtils;
  final MapRemoteDatasource mapRemoteDatasource;

  final UpdateYourVehicle updateYourVehicle;
  final UpdateYourPosition updateYourPosition;
  final UpdateYourDestination updateYourDestination;
  final UpdateAnotherPositions updateAnotherPositions;

  const InitGoogleMap({
    required this.bloc,
    required this.mapUtils,
    required this.mapRemoteDatasource,
    required this.updateYourVehicle,
    required this.updateYourPosition,
    required this.updateYourDestination,
    required this.updateAnotherPositions,
  });

  @override
  Future<Either<Failure, bool>> call(BuildContext context) async {
    logPrint('InitGoogleMap -> call()');
    BitmapDescriptor yourPositionIcon = await mapUtils.loadMarkerImageFromAsset(
        context, 'assets/icons/ic_my_transport.png');
    BitmapDescriptor busStopIcon = await mapUtils.loadMarkerImageFromAsset(
        context, 'assets/icons/ic_bus_stop.png');

    /// Set icons
    bloc.add(GeoUpdateIcons(
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
    bloc.add(GeoInitMapThemes(mapThemes: {
      MapThemeStyle.light: lightMapTheme,
      MapThemeStyle.dark: darkMapTheme,
    }));

    /// Service data
    const int instantID = 12;
    const int regionID = 3000;
    const String date = '2021-11-19';

    _TempVehicleData? tempVehicleData;
    final Set<VehiclePosition> vehicleAnotherPositions = {};

    var amount = 100;
    var counter = 0;

    var vehicles =
        await mapRemoteDatasource.getRegionVehicles(instantID, regionID);

    if (vehicles == null || vehicles.isEmpty) {
      return const Left(CommonFailure('vehicles is empty'));
    }

    /// Get all active vehicle
    vehicles.getRange(0, amount).forEach((vehicle) async {
      /// Get vehicle schedule to check whether it is active or not
      var schedule = await mapRemoteDatasource.getVehicleFullSchedule(
        instantID,
        vehicle.vehicleID,
        date,
      );

      if (schedule == null || !schedule.finalTime.isAfter(DateTime.now())) {
        counter++;
        return;
      }

      /// Get vehicle route data
      var route = await mapRemoteDatasource.getVehicleTimetable(
        instantID,
        regionID,
        vehicle.vehicleID,
        date,
      );

      if (route == null || route.timetable.isEmpty) {
        counter++;
        return;
      }

      /// Get vehicle bus stops
      var busStops = await mapRemoteDatasource.getVehicleBusStops(
        instantID,
        vehicle.vehicleID,
      );

      if (busStops == null) {
        counter++;
        return;
      }

      /// Get all vehicles in the route
      var positions = await mapRemoteDatasource.getVehiclePosition(
        instantID,
        regionID,
        vehicle.vehicleID,
        route.timetable[0].routeID,
        busStops.map((s) => s.busStopID).toList(),
      );

      if (positions == null) {
        counter++;
        return;
      }

      tempVehicleData ??= _TempVehicleData(
        vehicleData: vehicle,
        vehicleBusStops: busStops,
        vehiclePosition:
            positions.firstWhere((pos) => pos.vehicleID == vehicle.vehicleID),
        routeID: route.timetable[0].routeID,
      );
      vehicleAnotherPositions
          .addAll(positions.where((pos) => pos.vehicleID != vehicle.vehicleID));
      counter++;
    });

    while (counter != amount) {
      await Future.delayed(const Duration(seconds: 1));
    }

    if (tempVehicleData != null) {
      logPrint('vehicles is full');
      logPrint('vehicles - ${vehicleAnotherPositions.length + 1}');

      updateYourVehicle.call(tempVehicleData!.vehicleData);
      updateYourPosition.call(tempVehicleData!.vehiclePosition);
      updateYourDestination.call(VehicleRouteDestination(
        routeID: tempVehicleData!.routeID,
        routeName: 'routeName',
        startBusStop: tempVehicleData!.vehicleBusStops.first,
        destinationBusStop:
            tempVehicleData!.vehicleBusStops.last,
        busStops: tempVehicleData!.vehicleBusStops,
      ));
      updateAnotherPositions.call(vehicleAnotherPositions.toList());
    } else {
      logPrint('vehicles is empty');
      return const Left(CommonFailure('vehicles is empty'));
    }

    return const Right(true);
  }
}

class _TempVehicleData {
  final VehicleData vehicleData;
  final List<VehicleBusStopData> vehicleBusStops;
  final VehiclePosition vehiclePosition;
  final int routeID;

  const _TempVehicleData({
    required this.vehicleData,
    required this.vehicleBusStops,
    required this.vehiclePosition,
    required this.routeID,
  });
}
