import 'package:dio/dio.dart';
import 'package:noko_prototype/core/utils/logger.dart';

class RemoteDataSource {
  final String url = 'https://transport.iba.by/noko/api/nokoProd';
  final String username = 'skrskr';

  static const _httpErrorCodesResponse = <int, String>{
    0: 'Ошибка',
    1: 'Успех',
    212: 'Нет расписания на завтра для данного ТС',
    222: 'Наряд по тс не создан',
    302: 'Неверное имя пользователя, пользователь не существует',
    303: 'Сутки закончились, необходимо заново активировать мониторинг',
  };

  void handleResponseStatusErrors(DioError error) {
    throw Exception(
        'Response status code = ${error.response != null ? error.response!.statusCode : 'null'}, error: ${error.response != null ? error.response!.statusMessage : 'null'}');
  }

  void handleRequest(String requestURL) {
    logPrint('---> HTTP REQUEST:');
    logPrint(requestURL);
  }

  bool handleResponse(Response? response, [List<int>? errorCodes]) {
    if (response == null || response.data == null) {
      return false;
    }

    logPrint('<--- HTTP RESPONSE:');
    logPrint(response.toString());

    if (errorCodes != null && errorCodes.isNotEmpty) {
      for (var code in errorCodes) {
        if (response.data['code'] == code) {
          logPrint(_httpErrorCodesResponse[code]!);
          return false;
        }
      }
    }

    if (response.data is List<dynamic>) {
      return response.data != null && (response.data as List<dynamic>).isNotEmpty;
    } else {
      return response.data['data'] != null && (response.data as Map<dynamic, dynamic>).isNotEmpty;
    }
  }
}
