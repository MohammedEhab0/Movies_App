import 'package:injectable/injectable.dart';
import 'package:copy_movie/Data/models/MovieRespone.dart';

import '../../../../api/EndPoints.dart';
import '../../../../api/apiConstants.dart';
import '../../../../api/apiManger.dart';
import '../SearchRemoteDataSource.dart';

@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiManger apiManger;

  SearchRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<MoviesResponse?> movieSearch({required String searchWord}) async {
    print({'query_term': searchWord});

    final response = await apiManger.getData(
      baseUrl: ApiConstants.moviesBaseUrl,
      endPoint: EndPoints.listMovies,
      queryParameters: {
        "query_term": searchWord,
      },
    );

    print('🔍 API response: ${response.data}');

    try {
      final parsed = MoviesResponse.fromJson(response.data);
      return parsed;
    } catch (e, stack) {
      print('❌ Failed to parse MoviesResponse: $e');
      print(stack);
      throw Exception('Invalid movie response format');
    }
  }
}
