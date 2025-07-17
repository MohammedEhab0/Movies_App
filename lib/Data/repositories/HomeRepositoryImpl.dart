import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/data_sources/remote/HomeTabDataSource.dart';
import 'package:movie_app/Data/models/MovieRespone.dart';

import 'HomeRepository.dart';
@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository{
  HomeTabDataSource homeTabDataSource;
  HomeRepositoryImpl({required this.homeTabDataSource});
  @override
  Future<MoviesResponse?> fetchMovies() async{
    return homeTabDataSource.fetchMovies();

  }
}