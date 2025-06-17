import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/api/EndPoints.dart';
import 'package:copy_movie/api/apiConstants.dart';
import 'package:copy_movie/api/apiManger.dart';
import 'package:copy_movie/ui/homescreen/tabs/home/Cubit/movie_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesLoading());
  final apiManger = ApiManger();

  Future<void> fetchMovies() async {
    emit(MoviesLoading());

    try {
      emit(MoviesLoading());
      var response = await apiManger.getData(
          baseUrl: ApiConstants.moviesBaseUrl, endPoint: EndPoints.listMovies);

      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        emit(MoviesError(response.statusMessage!));
        return;
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final moviesResponse = MoviesResponse.fromJson(response.data);

        emit(MoviesSucess(moviesResponse.data!.movies ?? []));
        return;
      }
    } catch (e) {
      emit(MoviesError('Connection error: ${e.toString()}'));
    }
  }
}
