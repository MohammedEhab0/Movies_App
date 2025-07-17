import 'package:movie_app/Data/models/MovieRespone.dart';

abstract class BrowseTabDataSource {
  Future<MoviesResponse?> getMovies(String genre);
}