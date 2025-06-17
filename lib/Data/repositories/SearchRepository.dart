
import '../models/MovieRespone.dart';

abstract class SearchRepository{
  Future<MoviesResponse?> movieSearch({required String searchWord});
}