import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/repositories/browse%20tab/browse_tab_repository.dart';
import 'package:movie_app/ui/homescreen/tabs/explore/Cubit/browse_states.dart';

@injectable
class BrowseViewModel extends Cubit<BrowseStates> {
  BrowseTabRepository repository;
  BrowseViewModel({required this.repository}) : super(BrowseLoadingState());

  int selectedIndex = 0;
  final List<String> genres = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "Horror",
    "Music",
    "Musical",
    "Romance",
    "Sci‑Fi",
    "Thriller",
    "Western",
  ];


  void getMovies(String genre) async {
    try {
      emit(BrowseLoadingState());
      var response = await repository.retrieveMovies(genre);
      /// Handle States
      if (response?.data != null) {
        emit(BrowseSuccessState(movieList: response!.data!.movies));
      } else {
        emit(BrowseErrorState(errorMessage: "There are Api problem"));
      }
    } catch (e) {
      print('❌ Failed to return MoviesResponse in view model: $e');
      emit(BrowseErrorState(errorMessage: e.toString()));
    }
  }
}