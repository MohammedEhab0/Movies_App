import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/Data/repositories/HomeRepository.dart';
import 'package:copy_movie/ui/homescreen/tabs/home/Cubit/movie_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MoviesCubit extends Cubit<MoviesState> {
  final HomeRepository homeRepository;

  MoviesCubit({required this.homeRepository}) : super(MoviesLoading());

  Future<void> fetchMovies() async {
    emit(MoviesLoading()); // emit loading state

    try {
      final response = await homeRepository.fetchMovies();

      if (response == null) {
        emit(MoviesError("Null response from server"));
        print("Null response from server");
        return;
      }

      if (response.status == 'error') {
        emit(MoviesError(response.statusMessage ?? "Unknown error occurred"));
        print(response.statusMessage ?? "Unknown error occurred");
      } else if (response.status == 'ok' && response.data?.movies != null) {
        emit(MoviesSucess(response.data!.movies!));
      } else {
        emit(MoviesError("No movies found or invalid data"));
      }
    } catch (e, stack) {
      print("MoviesCubit error: $e");
      print(stack);
      emit(MoviesError('Connection error: ${e.toString()}'));
    }
  }
}
