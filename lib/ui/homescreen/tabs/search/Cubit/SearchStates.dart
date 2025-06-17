import '../../../../../Data/models/MovieRespone.dart';
import '../../../../../errors/Errors.dart';

abstract class SearchState {}
class SearchLoadingState extends SearchState{}
class SearchErrorState extends SearchState{
  String error ;
  SearchErrorState ({required this.error});
}
class SearchSuccessState extends SearchState{
  final List<Movies> movies;
  SearchSuccessState({required this.movies});
}