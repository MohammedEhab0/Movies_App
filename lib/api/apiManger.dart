import 'package:copy_movie/api/apiConstants.dart';
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
    return dio.get(baseUrl + endPoint, queryParameters: queryParameters);
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
        headers: {"Content-Type": "application/json"},
      ),
    );
  }

  Future<Response> getMovieDetails(int movieId) {
    return getData(
      baseUrl: ApiConstants.moviesBaseUrl,
      endPoint: "/movie_details.json",
      queryParameters: {"movie_id": movieId, "with_cast": "true"},
    );
  }
}
