import 'package:copy_movie/Data/models/MovieRespone.dart';

abstract class HomeTabDataSource{
  Future<MoviesResponse?>fetchMovies();
}