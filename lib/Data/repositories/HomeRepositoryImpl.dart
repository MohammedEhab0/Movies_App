import 'package:copy_movie/Data/data_sources/remote/HomeTabDataSource.dart';
import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:injectable/injectable.dart';

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