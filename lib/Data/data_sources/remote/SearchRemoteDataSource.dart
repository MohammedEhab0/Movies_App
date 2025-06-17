import 'package:copy_movie/Data/models/MovieRespone.dart';


abstract class SearchRemoteDataSource {
  Future<MoviesResponse?> movieSearch({required String searchWord});
}