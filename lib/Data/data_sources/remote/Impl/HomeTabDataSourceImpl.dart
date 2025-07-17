import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/data_sources/remote/HomeTabDataSource.dart';
import 'package:movie_app/Data/models/MovieRespone.dart';

import '../../../../api/EndPoints.dart';
import '../../../../api/apiConstants.dart';
import '../../../../api/apiManger.dart';

@Injectable(as: HomeTabDataSource)
class HomeTabDataSourceImpl implements HomeTabDataSource{
  ApiManger apiManger  ;
  HomeTabDataSourceImpl({required this.apiManger});
  @override
  Future<MoviesResponse?> fetchMovies() async {
    final response = await apiManger.getData(
      baseUrl: ApiConstants.moviesBaseUrl,
      endPoint: EndPoints.listMovies,
    );

    return MoviesResponse.fromJson(response.data); // ✅ CORRECTED
  }

  Future<Movies?> fetchMovieDetails(int movieId) async {
    final response = await apiManger.getData(
      baseUrl: ApiConstants.moviesBaseUrl,
      endPoint: "/movie_details.json",
      queryParameters: {"movie_id": movieId, "with_cast": "true"},
    );
    final movieJson = response.data["data"]["movie"];
    final movie = Movies.fromJson(movieJson);
    return movie;
  }
}