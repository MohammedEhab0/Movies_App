import 'package:copy_movie/Data/models/MovieRespone.dart';

abstract class BrowseTabDataSource {
  Future<MoviesResponse?> getMovies(String genre);
}