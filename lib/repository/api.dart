import 'package:dio/dio.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  final Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = BASEURL;

    ///intercept every request and response
    _dio.interceptors.add(PrettyDioLogger());
    // _dio.options.headers =
  }

  Dio get sendRequest => _dio;
}
