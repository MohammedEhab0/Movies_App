import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManger {
  static final dio = Dio();

  Future<Response> getData({
    required String baseUrl,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return dio.get(
      baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          "Content-Type": "application/json",
          if(headers!=null)...headers //spread operator
        },
      ),
    );
  }

  Future<Response> postData({
    required String baseUrl,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers, // <-- add this
  }) {
    return dio.post(
      baseUrl + endPoint,
      queryParameters: queryParameters,
      data: body,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          "Content-Type": "application/json",
          if (headers != null) ...headers,
        },
      ),
    );
  }


  /// get user date
  Future<Response> getUser({
    required String baseUrl,
    required String endPoint,
    required String token,
  }) {
    return dio.get(
      baseUrl + endPoint,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      ),
    );
  }

  /// update user data
  Future<Response> updateUser({
    required String baseUrl,
    required String endPoint,
    required String token,
    Map<String, dynamic>? body,
  }) {
    return dio.patch(
      baseUrl + endPoint,
      data: body,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
          "Accept": "application/json"
        },
      ),
    );
  }

  /// delete user
  Future<Response> deleteUser({
    required String baseUrl,
    required String endPoint,
    required String token,
  }) {
    return dio.delete(
      baseUrl + endPoint,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      ),
    );
  }

  Future<Response> deleteMovie({
    required String baseUrl,
    required String endPoint,
    required String token,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.delete(
      baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (status) => true,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      ),
    );
  }
}
