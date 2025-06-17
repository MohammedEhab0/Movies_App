import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/api/EndPoints.dart';
import 'package:copy_movie/api/apiConstants.dart';
import 'package:copy_movie/api/apiManger.dart';
import 'package:copy_movie/ui/homescreen/tabs/explore/Cubit/browse_states.dart';
import 'package:dio/src/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowseViewModel extends Cubit<BrowseStates> {
  BrowseViewModel() : super(BrowseLoadingState());
  final apiManager = ApiManger();

  void getMovies(String genre) async {
    try {
      emit(BrowseLoadingState());
      /// Request
      Response response = await apiManager.getData(
        baseUrl: ApiConstants.moviesBaseUrl,
        endPoint: EndPoints.listMovies,
        queryParameters: {
          "genre":genre
        }
      );
      /// Handle States
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final movieList = MoviesResponse.fromJson(response.data);
        emit(BrowseSuccessState(movieList: movieList.data!.movies));
      } else {
        emit(BrowseErrorState(errorMessage: "There are Api problem"));
      }
    } catch (e) {
      emit(BrowseErrorState(errorMessage: e.toString()));
    }
  }
}