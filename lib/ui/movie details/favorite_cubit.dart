import 'package:bloc/bloc.dart';
import 'package:movie_app/Data/models/AddToFavorite.dart';
import 'package:movie_app/Data/models/DeleteMovie.dart';
import 'package:movie_app/Data/models/IsFavoriteModel.dart';
import 'package:movie_app/Data/models/MovieRespone.dart';
import 'package:movie_app/api/EndPoints.dart';
import 'package:movie_app/api/apiConstants.dart';
import 'package:movie_app/api/apiManger.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final ApiManger apiManager;

  FavoriteCubit(this.apiManager) : super(FavoriteInitial());

  Future<void> checkFavorite(int movieId, String token) async {
    emit(FavoriteLoading());

    try {
      final response = await apiManager.getData(
        baseUrl: ApiConstants.FavouriteItemsBaseUrl,
        endPoint: EndPoints.isFavorite.replaceFirst(
          "movieId",
          movieId.toString(),
        ),
        headers: {'Authorization': 'Bearer $token'},
      );

      final parsed = IsFavoriteModel.fromJson(response.data);

      if (response.statusCode == 200 && parsed.data != null) {
        emit(FavoriteLoaded(parsed.data!));
      } else {
        emit(const FavoriteLoaded(false));
      }
    } catch (e) {
      emit(const FavoriteLoaded(false));
    }
  }

  Future<void> toggleFavorite(
    bool isCurrentlyFavorite,
    Movies movie,
    String token,
  ) async {
    emit(FavoriteLoading());

    try {
      final movieId = movie.id?.toString();
      final name = movie.title?.trim().isNotEmpty == true
          ? movie.title!
          : "Untitled";
      final rating = movie.rating ?? 0.0;
      final imageURL =
          movie.mediumCoverImage ??
          movie.largeCoverImage ??
          movie.smallCoverImage ??
          '';
      final year = movie.year?.toString() ?? "Unknown";

      if (movieId == null) {
        emit(FavoriteError("Invalid movie ID"));
        return;
      }

      if (isCurrentlyFavorite) {
        final response = await apiManager.deleteMovie(
          baseUrl: ApiConstants.FavouriteItemsBaseUrl,
          endPoint: EndPoints.removeFromFavorite.replaceFirst(
            "movieId",
            movieId,
          ),
          token: token,
        );

        final parsed = DeleteMovie.fromJson(response.data);

        if (response.statusCode == 200 &&
            parsed.message?.toLowerCase().contains("success") == true) {
          emit(const FavoriteLoaded(false));
        } else {
          emit(
            FavoriteError(parsed.message ?? "Failed to remove from favorite"),
          );
        }
      } else {
        final response = await apiManager.postData(
          baseUrl: ApiConstants.FavouriteItemsBaseUrl,
          endPoint: EndPoints.addToFavorite,
          headers: {'Authorization': 'Bearer $token'},
          body: {
            "movieId": movieId,
            "name": name,
            "rating": rating,
            "imageURL": imageURL,
            "year": year,
          },
        );

        final parsed = AddToFavorite.fromJson(response.data);
        final msg = parsed.message?.toLowerCase() ?? '';

        if ((response.statusCode == 200 || response.statusCode == 201) &&
            msg.contains("success")) {
          emit(const FavoriteLoaded(true));
        } else if (response.statusCode == 409 && msg.contains("already")) {
          emit(FavoriteError("Movie already in favorites"));
        } else {
          emit(FavoriteError(parsed.message ?? "Failed to add to favorite"));
        }
      }
    } catch (e, stackTrace) {
      print("FavoriteCubit Error: $e");
      print("STACK TRACE: $stackTrace");
      emit(FavoriteError("Something went wrong"));
    }
  }
}
