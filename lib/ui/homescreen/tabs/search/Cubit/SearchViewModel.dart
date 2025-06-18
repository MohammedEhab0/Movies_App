import 'package:flutter/material.dart'; // Use material.dart for TextEditingController
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../Data/models/MovieRespone.dart';

import '../../../../../Data/repositories/SearchRepository.dart';
import 'SearchStates.dart';

@injectable
class SearchViewModel extends Cubit<SearchState>{
  final SearchRepository searchRepository; // Make it final as it's injected
  SearchViewModel({required this.searchRepository}) : super(SearchLoadingState());
  final TextEditingController searchController = TextEditingController();

  List<Movies> searchList = [];

  Future<void> Search(String searchWord) async {
    emit(SearchLoadingState());
    try {
      var response = await searchRepository.movieSearch(searchWord: searchWord);
      if (response?.status == 'error') {
        emit(SearchErrorState(error: response!.statusMessage!));
        return;
      } else if (response?.status == 'ok') {
        searchList = response!.data!.movies!;
        emit(SearchSuccessState(movies: searchList));
      }
    } catch (e) {
      emit(SearchErrorState(error: e.toString()));
    }
  }

  // Remember to dispose of the controller if you create it here
  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
    }
}