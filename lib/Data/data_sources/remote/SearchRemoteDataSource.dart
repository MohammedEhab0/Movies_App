import 'package:movie_app/Data/models/MovieRespone.dart';

abstract class SearchRemoteDataSource {
  Future<MoviesResponse?> movieSearch({required String searchWord});
}