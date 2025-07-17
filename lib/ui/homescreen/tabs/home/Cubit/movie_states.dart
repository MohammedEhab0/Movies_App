import 'package:movie_app/Data/models/MovieRespone.dart';

abstract class MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesSucess extends MoviesState {
  final List<Movies> movies;

  MoviesSucess(this.movies);
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message);
}
