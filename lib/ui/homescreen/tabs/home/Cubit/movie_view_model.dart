import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/models/MovieRespone.dart';
import 'package:movie_app/api/EndPoints.dart';
import 'package:movie_app/api/apiConstants.dart';
import 'package:movie_app/api/apiManger.dart';
import 'package:movie_app/ui/homescreen/tabs/home/Cubit/movie_states.dart';
@injectable
class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesLoading());
  final apimanger = ApiManger();

  Future<void> fetchMovies() async {
    emit(MoviesLoading());
    try {
      var response = await apimanger.getData(
        baseUrl: ApiConstants.moviesBaseUrl,
        endPoint: EndPoints.listMovies,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final moviesResponse = MoviesResponse.fromJson(response.data);
        emit(MoviesSucess(moviesResponse.data!.movies ?? []));
      } else {
        emit(MoviesError(response.statusMessage!));
      }
    } catch (e) {
      emit(MoviesError('Connection error: ${e.toString()}'));
    }
  }

  Future<Movies?> fetchMovieDetails(int movieId) async {
    try {
      final response = await apimanger.getData(
        baseUrl: ApiConstants.moviesBaseUrl,
        endPoint: "/movie_details.json",
        queryParameters: {
          "movie_id": movieId,
          "with_cast": "true",
          "with_images": "true"
        },
      );

      if (response.statusCode == 200 && response.data["status"] == "ok") {
        final movieJson = response.data["data"]["movie"];
        final movie = Movies.fromJson(movieJson);
        print("SUMMARY => ${movie.descriptionFull}");
        print("RAW JSON => $movieJson");
        print("SUMMARY => ${movie.descriptionFull}");
        return movie;
      } else {
        emit(MoviesError("Failed to load movie details"));
        return null;
      }
    } catch (e) {
      emit(MoviesError("Error: ${e.toString()}"));
      return null;
    }
  }
}
