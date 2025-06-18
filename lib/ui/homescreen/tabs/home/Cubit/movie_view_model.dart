import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/Data/repositories/HomeRepository.dart';
import 'package:copy_movie/api/EndPoints.dart';
import 'package:copy_movie/api/apiConstants.dart';
import 'package:copy_movie/api/apiManger.dart';
import 'package:copy_movie/ui/homescreen/tabs/home/Cubit/movie_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit({required this.homeRepository}) : super(MoviesLoading());
  HomeRepository homeRepository;

  Future<void> fetchMovies() async {
    emit(MoviesLoading());

    try {
      emit(MoviesLoading());
      var response = await homeRepository.fetchMovies();

      if (response?.status == 'error') {
        emit(MoviesError( response!.statusMessage!));
        return;
      } else if (response?.status == 'ok') {
        emit(MoviesSucess( response!.data!.movies!));
        return;
      };
      }
    catch (e) {
      emit(MoviesError('Connection error: ${e.toString()}'));
    }
  }
}
