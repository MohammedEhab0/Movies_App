import 'package:copy_movie/Data/models/MovieRespone.dart';

abstract class BrowseStates{}

/// Loading State
class BrowseLoadingState extends BrowseStates{}
/// Error State
class BrowseErrorState extends BrowseStates{
  String? errorMessage;
  BrowseErrorState({required this.errorMessage});
}
/// Success State
class BrowseSuccessState extends BrowseStates{
  List<Movies>? movieList;
  BrowseSuccessState({required this.movieList});
}