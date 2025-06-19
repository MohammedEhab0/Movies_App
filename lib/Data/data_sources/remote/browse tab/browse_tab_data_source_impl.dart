import 'package:copy_movie/Data/data_sources/remote/browse%20tab/browse_tab_data_source.dart';
import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/api/EndPoints.dart';
import 'package:copy_movie/api/apiConstants.dart';
import 'package:copy_movie/api/apiManger.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BrowseTabDataSource)
class BrowseTabDataSourceImpl implements BrowseTabDataSource {
  ApiManger apiManger;

  BrowseTabDataSourceImpl({required this.apiManger});

  @override
  Future<MoviesResponse?> getMovies(String genre) async {
    try {
      var response = await apiManger.getData(
        baseUrl: ApiConstants.moviesBaseUrl,
        endPoint: EndPoints.listMovies,
        queryParameters: {"genre": genre},
      );
      return MoviesResponse.fromJson(response.data);
    } catch (e) {
      print('❌ Failed to return MoviesResponse in DataSource: $e');
      throw Exception('Invalid movie response format');
    }
  }
}
