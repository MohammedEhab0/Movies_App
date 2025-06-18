import '../models/MovieRespone.dart';

abstract class HomeRepository{
  Future<MoviesResponse?>fetchMovies();
}