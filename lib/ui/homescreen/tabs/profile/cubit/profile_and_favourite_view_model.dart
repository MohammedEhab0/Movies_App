import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/repositories/getProfile/ProfileRepository.dart';
import 'package:movie_app/ui/homescreen/tabs/profile/cubit/profile_and_favourite_states.dart';

// IMPORTANT: Ensure this points to your redefined FavouriteModelItem.dart
import '../../../../../Data/models/FavouriteModelItem.dart'; // This now defines FavouriteItemModel directly
import '../../../../../Data/models/MovieRespone.dart';
import '../../../../../Data/models/ProfileModel.dart';
import '../../../../../Data/repositories/FavouriteItems/favouriteRepository.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../Di/di.dart';
import '../../home/Cubit/movie_view_model.dart';

@injectable
class ProfileViewModel extends Cubit<ProfilesStates> {
  final ProfileRepository profileRepository;
  final FavouriteRepository favouriteRepository;

  ProfileModel? _currentProfileData;
  List<
      FavouriteItemModel>? _currentFavouriteData; // This is List<FavouriteItemModel>?
  String? _currentProfileError;
  String? _currentFavouriteError;

  ProfileViewModel({
    required this.profileRepository,
    required this.favouriteRepository,
  }) : super(ProfilesLoading());

  final List<String> avatarList = [
    AppAssets.character1, AppAssets.character2, AppAssets.character3,
    AppAssets.character4, AppAssets.character5, AppAssets.character6,
    AppAssets.character7, AppAssets.character8, AppAssets.character9,
  ];

  String getAvatarById(int? id) {
    if (id == null) return AppAssets.character6;
    return avatarList[id.clamp(0, avatarList.length - 1)];
  }

  Future<void> fetchProfileAndFavourites(String token) async {
    _currentProfileData = null;
    _currentFavouriteData = null;
    _currentProfileError = null;
    _currentFavouriteError = null;

    emit(ProfileAndFavouritesLoading());

    if (token.isEmpty) {
      emit(ProfileAndFavouritesError("No token found. Please login again."));
      return;
    }

    final profileFuture = profileRepository.fetchProfile(token);
    // ASSUMPTION: favouriteRepository.fetchFavourites now returns Future<Either<NetworkException, List<FavouriteItemModel>>>
    final favouritesFuture = favouriteRepository.fetchFavourites(token: token);

    await Future.wait([
      profileFuture.then((either) {
        either.fold(
              (error) => _currentProfileError = error.errorMessage,
              (response) => _currentProfileData = response,
        );
      }).catchError((e) {
        _currentProfileError = 'Error fetching profile: ${e.toString()}';
        print("ProfileViewModel profile fetch exception: $e");
      }),
      favouritesFuture.then((either) {
        either.fold(
              (error) => _currentFavouriteError = error.errorMessage,
          // *** SIMPLIFIED HERE ***
          // Directly assign responses to _currentFavouriteData
          // because favouriteRepository.fetchFavourites should now return List<FavouriteItemModel>
              (responses) => _currentFavouriteData = responses,
        );
      }).catchError((e) {
        _currentFavouriteError = 'Error fetching favourites: ${e.toString()}';
        print("ProfileViewModel favourite fetch exception: $e");
      }),
    ]);

    if (_currentProfileData == null && _currentFavouriteData == null &&
        (_currentProfileError != null || _currentFavouriteError != null)) {
      emit(ProfileAndFavouritesError(
          'Failed to load both profile and favourites. '
              'Profile: ${_currentProfileError ?? 'N/A'}, '
              'Favourites: ${_currentFavouriteError ?? 'N/A'}'
      ));
    } else {
      emit(ProfileAndFavouritesSuccess(
        profile: _currentProfileData,
        favourites: _currentFavouriteData,
        profileErrorMessage: _currentProfileError,
        favouriteErrorMessage: _currentFavouriteError,
      ));
    }
  }

  // --- Original individual fetch methods (keep if needed, but ensure they use correct types) ---
  Future<void> fetchProfile(String token) async {
    emit(ProfilesLoading());
    if (token.isEmpty) {
      emit(ProfilesError("No token found. Please login again."));
      return;
    }
    try {
      final either = await profileRepository.fetchProfile(token);
      either.fold(
            (error) {
          emit(ProfilesError(error.errorMessage));
          print("Profile Error: ${error.errorMessage}");
        },
            (response) {
          if (response.data == null) {
            emit(ProfilesError("No profile data found"));
            print("No profile data found");
          } else {
            emit(ProfilesSuccess(response));
          }
        },
      );
    } catch (e, stack) {
      print("ProfileViewModel exception: $e");
      print(stack);
      emit(ProfilesError('Unexpected error: ${e.toString()}'));
    }
  }

  // Ensure this method also returns List<FavouriteItemModel>
  Future<void> fetchFavourites(String token) async {
    emit(FavouritesLoading());
    if (token.isEmpty) {
      emit(FavouritesError("No token found. Please login again."));
      return;
    }
    try {
      // Assuming this now returns Future<Either<NetworkException, List<FavouriteItemModel>>>
      final either = await favouriteRepository.fetchFavourites(token: token);
      either.fold(
            (error) {
          emit(FavouritesError(error.errorMessage));
          print("Favourites Error: ${error.errorMessage}");
        },
            (responses) {
              // Here, 'responses' should directly be List<FavouriteItemModel>
          emit(FavouritesSuccess(responses));
        },
      );
    } catch (e, stack) {
      print("Favourite exception: $e");
      print(stack);
      emit(FavouritesError('Unexpected error: ${e.toString()}'));
    }
  }

  Future<Movies?> fetchMovieDetails(int movieId) async {
    try {
      final moviesCubit = getIt<MoviesCubit>();
      return await moviesCubit.fetchMovieDetails(movieId);
    } catch (e) {
      print('Error fetching movie details: $e');
      return null;
    }
  }
}