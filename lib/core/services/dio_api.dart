import 'package:bingo_project/core/services/config.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class Api {
  final Dio _dio = Dio();
  Api() {
    _dio.options.headers = {};
    _dio.options.baseUrl = basUrl;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      responseBody: true,
    ));
  }
  Dio get sendRequest => _dio;
}
