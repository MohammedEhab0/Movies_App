import 'package:copy_movie/Data/data_sources/remote/HomeTabDataSource.dart';
import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:injectable/injectable.dart';

import '../../../../api/EndPoints.dart';
import '../../../../api/apiConstants.dart';
import '../../../../api/apiManger.dart';

@Injectable(as: HomeTabDataSource)
class HomeTabDataSourceImpl implements HomeTabDataSource{
  ApiManger apiManger  ;
  HomeTabDataSourceImpl({required this.apiManger});
  @override
  Future<MoviesResponse?> fetchMovies() async{
    // TODO: implement fetchMovies
    var response = await apiManger.getData(
        baseUrl: ApiConstants.moviesBaseUrl, endPoint: EndPoints.listMovies);
      return MoviesResponse.fromJson(response);
  }
}