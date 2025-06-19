import 'package:copy_movie/Data/data_sources/remote/browse%20tab/browse_tab_data_source.dart';
import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/Data/repositories/browse%20tab/browse_tab_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BrowseTabRepository)
class BrowseTabRepositoryImpl implements BrowseTabRepository{
  BrowseTabDataSource dataSource;
  BrowseTabRepositoryImpl({required this.dataSource});

  @override
  Future<MoviesResponse?> retrieveMovies(String genre) {
    return dataSource.getMovies(genre);
  }

}