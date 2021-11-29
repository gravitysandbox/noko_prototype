import 'package:dio/dio.dart';
import 'package:noko_prototype/core/data/datasources/remote_datasource.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/models/region_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/route_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_bus_stop_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_position.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_schedule_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_timetable_data.dart';

class MapRemoteDatasource extends RemoteDataSource {
  final Dio _client = Dio();

  Future<List<RegionData>?> getRegions(int instanceID) async {
    logPrint('MapRemoteDatasource -> getRegions($instanceID)');
    final httpRequestURL = '$url/instanceId/$instanceID/regions';
    Response? response;

    try {
      handleRequest(httpRequestURL);
      response = await _client.get(httpRequestURL);
    } on DioError catch (e) {
      handleResponseStatusErrors(e);
    }

    if (response == null ||
        response.data == null ||
        response.data['data'] == null) {
      return null;
    }

    final responseData = response.data as Map<String, dynamic>;
    handleResponse(responseData);
    final List<RegionData> regions = [];

    for (var region in responseData['data'] as List) {
      regions.add(RegionData.fromJson(region));
    }

    return regions;
  }

  Future<List<VehicleData>?> getRegionVehicles(
    int instanceID,
    int regionID,
  ) async {
    logPrint(
        'MapRemoteDatasource -> getRegionVehicles($instanceID, $regionID)');
    final httpRequestURL = '$url/instanceId/$instanceID/vehicles';
    Response? response;

    try {
      handleRequest(httpRequestURL);
      response = await _client.get(httpRequestURL);
    } on DioError catch (e) {
      handleResponseStatusErrors(e);
    }

    if (response == null ||
        response.data == null ||
        response.data['data'] == null) {
      return null;
    }

    final responseData = response.data as Map<String, dynamic>;
    handleResponse(responseData);
    final List<VehicleData> regionVehicles = [];

    for (var vehicle in responseData['data'] as List) {
      if (vehicle['idRegion'] == regionID) {
        regionVehicles.add(VehicleData.fromJson(vehicle));
      }
    }

    return regionVehicles;
  }

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

    if (response == null ||
        response.data == null ||
        response.data['data'] == null) {
      return null;
    }

    final responseData = response.data as Map<String, dynamic>;
    handleResponse(responseData);
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

    if (response == null ||
        response.data == null ||
        response.data['data'] == null) {
      return null;
    }

    final responseData = response.data as Map<String, dynamic>;
    handleResponse(responseData);
    return VehicleShortScheduleData.fromJson(responseData['data']);
  }

  Future<VehicleFullScheduleData?> getVehicleFullSchedule(
    int instanceID,
    int vehicleID,
    String date,
  ) async {
    logPrint(
        'MapRemoteDatasource -> getVehicleFullSchedule($instanceID, $vehicleID, $date)');
    final httpRequestURL =
        '$url/instanceId/$instanceID/idVehicle/$vehicleID/DateNar/$date/scheduleTS';
    Response? response;

    try {
      handleRequest(httpRequestURL);
      response = await _client.get(httpRequestURL);
    } on DioError catch (e) {
      handleResponseStatusErrors(e);
    }

    if (response == null ||
        response.data == null ||
        response.data['data'] == null) {
      return null;
    }

    final responseData = response.data as Map<String, dynamic>;
    handleResponse(responseData);
    return VehicleFullScheduleData.fromJson(responseData['data']);
  }

  Future<VehicleTimetableData?> getVehicleTimetable(
    int instanceID,
    int regionID,
    int vehicleID,
    String date,
  ) async {
    logPrint(
        'MapRemoteDatasource -> getVehicleTimetable($instanceID, $regionID, $vehicleID, $date)');
    final httpRequestURL =
        '$url/instanceId/$instanceID/date/$date/region/$regionID/idVehicle/$vehicleID/rasp';
    Response? response;

    try {
      handleRequest(httpRequestURL);
      response = await _client.get(httpRequestURL);
    } on DioError catch (e) {
      handleResponseStatusErrors(e);
    }

    if (response == null ||
        response.data == null ||
        response.data['data'] == null) {
      return null;
    }

    final responseData = response.data as Map<String, dynamic>;
    handleResponse(responseData);
    return VehicleTimetableData.fromJson(responseData['data']);
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

    if (response == null ||
        response.data == null ||
        response.data['data'] == null) {
      return null;
    }

    final responseData = response.data as Map<String, dynamic>;
    handleResponse(responseData);
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

    if (response == null || response.data == null) {
      return null;
    }

    final responseData = response.data as List<dynamic>;
    handleResponse(responseData);
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

    if (response == null ||
        response.data == null ||
        response.data['data'] == null) {
      return null;
    }

    final responseData = response.data as Map<String, dynamic>;
    handleResponse(responseData);
    final List<VehiclePosition> positions = [];

    for (var position in responseData['data'] as List) {
      positions.add(VehiclePosition.fromJson(position));
    }

    return positions;
  }
}
