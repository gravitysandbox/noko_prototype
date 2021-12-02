import 'package:dio/dio.dart';
import 'package:noko_prototype/core/data/datasources/remote_datasource.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_bus_stop_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_position.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_destination.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_schedule_data.dart';

class MapRemoteDatasource extends RemoteDataSource {
  final Dio _client = Dio();

  Future<List<RouteData>?> getRegionRoutes(
    int instanceID,
    int regionID,
  ) async {
    logPrint('MapRemoteDatasource -> getRegionRoutes($instanceID, $regionID)');
    final httpRequestURL = '$url/instanceId/$instanceID/selectMarhrut';
    Response? response;

    try {
      handleRequest(httpRequestURL);
      response = await _client.get(httpRequestURL);
    } on DioError catch (e) {
      handleResponseStatusErrors(e);
    }

    if (!handleResponse(response)) {
      return null;
    }

    final responseData = response!.data as Map<String, dynamic>;
    final List<RouteData> routes = [];

    for (var route in responseData['data'] as List) {
      if (route['idRegion'] == regionID) {
        routes.add(RouteData.fromJson(route));
      }
    }

    return routes;
  }

  Future<VehicleShortScheduleData?> getVehicleShortSchedule(
    int instanceID,
    int vehicleID,
  ) async {
    logPrint(
        'MapRemoteDatasource -> getVehicleShortSchedule($instanceID, $vehicleID)');
    final httpRequestURL =
        '$url/instanceId/$instanceID/idVehicle/$vehicleID/schedule';
    Response? response;

    try {
      handleRequest(httpRequestURL);
      response = await _client.get(httpRequestURL);
    } on DioError catch (e) {
      handleResponseStatusErrors(e);
    }

    if (!handleResponse(response, [212])) {
      return null;
    }

    final responseData = response!.data as Map<String, dynamic>;
    return VehicleShortScheduleData.fromJson(responseData['data']);
  }

  Future<VehicleRouteData?> getVehicleRouteData(
    int instanceID,
    int regionID,
    int vehicleID,
    String date,
  ) async {
    logPrint(
        'MapRemoteDatasource -> getVehicleRouteData($instanceID, $regionID, $vehicleID, $date)');
    final httpRequestURL =
        '$url/instanceId/$instanceID/date/$date/region/$regionID/idVehicle/$vehicleID/vData';
    Response? response;

    try {
      handleRequest(httpRequestURL);
      response = await _client.get(httpRequestURL);
    } on DioError catch (e) {
      handleResponseStatusErrors(e);
    }

    if (!handleResponse(response)) {
      return null;
    }

    final responseData = response!.data as Map<String, dynamic>;
    return VehicleRouteData.fromJson(responseData['data']);
  }

  Future<List<VehicleBusStopData>?> getVehicleBusStops(
    int instanceID,
    int vehicleID,
  ) async {
    logPrint(
        'MapRemoteDatasource -> getVehicleBusStops($instanceID, $vehicleID)');
    final httpRequestURL =
        '$url/instanceId/$instanceID/idVehicle/$vehicleID/getMarshrutStops';
    Response? response;

    try {
      handleRequest(httpRequestURL);
      response = await _client.get(httpRequestURL);
    } on DioError catch (e) {
      handleResponseStatusErrors(e);
    }

    if (!handleResponse(response)) {
      return null;
    }

    final responseData = response!.data as List<dynamic>;
    final List<VehicleBusStopData> busStops = [];

    for (var busStop in responseData) {
      busStops.add(VehicleBusStopData.fromJson(busStop));
    }

    return busStops;
  }

  Future<List<VehiclePosition>?> getVehiclePosition(
    int instanceID,
    int regionID,
    int vehicleID,
    int routeID,
    List<int> busStopIDs,
  ) async {
    logPrint(
        'MapRemoteDatasource -> getVehiclePosition($instanceID, $regionID, $vehicleID, $routeID, ${busStopIDs.length})');
    final httpRequestURL =
        '$url/checkTSnew?InstanceId=$instanceID&ownVehicle=$vehicleID';
    final body = {
      'UserName': username,
      'IdStopPoint': busStopIDs,
      'marshrutData': [
        {
          'idMarshrutWO': routeID,
          'idRegion': regionID,
        },
      ]
    };
    Response? response;

    try {
      handleRequest(httpRequestURL);
      response = await _client.post(
        httpRequestURL,
        data: body,
      );
    } on DioError catch (e) {
      handleResponseStatusErrors(e);
    }

    if (!handleResponse(response, [0, 302, 303])) {
      return null;
    }

    final responseData = response!.data as Map<String, dynamic>;
    final List<VehiclePosition> positions = [];

    for (var position in responseData['data'] as List) {
      positions.add(VehiclePosition.fromJson(position));
    }

    return positions;
  }

  Future<List<VehiclePosition>?> getMultipleVehiclePosition(
      int instanceID,
      int regionID,
      List<VehicleRouteDestination> destinations,
      ) async {
    logPrint(
        'MapRemoteDatasource -> getMultipleVehiclePosition($instanceID, $regionID, ${destinations.length})');
    final List<VehiclePosition> anotherPositions = [];
    var amount = destinations.length;
    var counter = 0;

    for (var destination in destinations) {
      final positions = await getVehiclePosition(instanceID, regionID, destination.vehicleID, destination.routeID, destination.busStops.map((s) => s.busStopID)
          .toList());

      if (positions != null) {
        anotherPositions.addAll(positions);
      }
      counter++;
    }

    while (counter != amount) {
      await Future.delayed(const Duration(seconds: 1));
    }

    return anotherPositions;
  }
}
