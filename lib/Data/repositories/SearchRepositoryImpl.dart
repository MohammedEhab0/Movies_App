import 'package:injectable/injectable.dart';
import '../data_sources/remote/SearchRemoteDataSource.dart';
import '../models/MovieRespone.dart';
import 'SearchRepository.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  SearchRemoteDataSource searchRemoteDataSource;
  SearchRepositoryImpl({required this.searchRemoteDataSource});
  @override
  Future<MoviesResponse?> movieSearch({required String searchWord}) {
    return searchRemoteDataSource.movieSearch(searchWord: searchWord);
    }
}