import 'package:dio/dio.dart';
import 'package:noko_prototype/core/utils/logger.dart';

class RemoteDataSource {
  final String url = 'https://transport.iba.by/noko/api/nokoProd';
  final String username = 'skrskr';

  void handleResponseStatusErrors(DioError error) {
    throw Exception(
        'Response status code = ${error.response != null ? error.response!.statusCode : 'null'}, error: ${error.response != null ? error.response!.statusMessage : 'null'}');
  }

  void handleRequest(String requestURL) {
    logPrint('---> HTTP REQUEST:');
    logPrint(requestURL);
  }

  void handleResponse(dynamic response) {
    logPrint('<--- HTTP RESPONSE:');
    logPrint(response.toString());
  }
}