import 'package:dio/dio.dart';
import 'package:noko_prototype/core/data/datasources/remote_datasource.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/models/region_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_schedule_data.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_timetable_data.dart';

class GarageRemoteDatasource extends RemoteDataSource {
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

    if (!handleResponse(response)) {
      return null;
    }

    final responseData = response!.data as Map<String, dynamic>;
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

    if (!handleResponse(response)) {
      return null;
    }

    final responseData = response!.data as Map<String, dynamic>;
    final List<VehicleData> regionVehicles = [];

    for (var vehicle in responseData['data'] as List) {
      if (vehicle['idRegion'] == regionID) {
        regionVehicles.add(VehicleData.fromJson(vehicle));
      }
    }

    return regionVehicles;
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

    if (!handleResponse(response, [222])) {
      return null;
    }

    final responseData = response!.data as Map<String, dynamic>;
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

    if (!handleResponse(response)) {
      return null;
    }

    final responseData = response!.data as Map<String, dynamic>;
    return VehicleTimetableData.fromJson(responseData['data']);
  }
}