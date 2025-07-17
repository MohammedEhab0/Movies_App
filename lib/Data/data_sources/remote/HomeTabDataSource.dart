import 'package:movie_app/Data/models/MovieRespone.dart';

abstract class HomeTabDataSource{
  Future<MoviesResponse?>fetchMovies();
}