import 'package:copy_movie/Data/models/MovieRespone.dart';

abstract class BrowseTabRepository {
  Future<MoviesResponse?> retrieveMovies(String genre);
}