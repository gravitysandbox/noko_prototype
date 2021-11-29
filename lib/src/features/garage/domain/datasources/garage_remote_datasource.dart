import 'package:dio/dio.dart';
import 'package:noko_prototype/core/data/datasources/remote_datasource.dart';

class GarageRemoteDatasource extends RemoteDataSource {
  final Dio _client = Dio();
}