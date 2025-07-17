import 'package:movie_app/Data/models/MovieRespone.dart';

abstract class BrowseTabRepository {
  Future<MoviesResponse?> retrieveMovies(String genre);
}