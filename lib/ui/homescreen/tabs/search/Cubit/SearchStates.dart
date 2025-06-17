import '../../../../../errors/Errors.dart';

abstract class SearchState {}
class SearchLoadingState extends SearchState{}
class SearchErrorState extends SearchState{
  Errors error ;
  SearchErrorState ({required this.error});
}
class SearchSuccessState extends SearchState{}