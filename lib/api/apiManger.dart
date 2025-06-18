import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManger {
  static final dio = Dio();

  Future<Response> getData({
    required String baseUrl,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get(
      baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }

  Future<Response> postData({
    required String baseUrl,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Object? body,
  }) {
    return dio.post(
      baseUrl + endPoint,
      queryParameters: queryParameters,
      data: body,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }
}
