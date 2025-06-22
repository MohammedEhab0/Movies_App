import 'package:copy_movie/Data/repositories/getProfile/ProfileRepository.dart';
import 'package:copy_movie/Providers/UserProvider.dart';
import 'package:copy_movie/ui/homescreen/tabs/profile/cubit/profile_and_favourite_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

import '../../../../../Data/repositories/FavouriteItems/favouriteRepository.dart';
import '../../../../../utils/app_assets.dart';

@injectable
class ProfileViewModel extends Cubit<ProfilesStates> {
  final ProfileRepository profileRepository;
  final FavouriteRepository favouriteRepository;

  var userProvider = Provider.of<UserProvider>(context);
  ProfileViewModel({
    required this.profileRepository,
    required this.favouriteRepository,
    required this.userProvider,
  }) : super(ProfilesLoading());

  final List<String> avatarList = [
    AppAssets.character1,
    AppAssets.character2,
    AppAssets.character3,
    AppAssets.character4,
    AppAssets.character5,
    AppAssets.character6,
    AppAssets.character7,
    AppAssets.character8,
    AppAssets.character9,
  ];

  String getAvatarById(int? id) {
    if (id == null) return AppAssets.character6;
    return avatarList[id.clamp(0, avatarList.length - 1)];
  }

  Future<void> fetchProfile() async {
    emit(ProfilesLoading());

    final token = userProvider.currentUser?.token;

    if (token == null || token.isEmpty) {
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

  Future<void> fetchFavourites() async {
    emit(FavouritesLoading());

    final token = userProvider.currentUser?.token;

    if (token == null || token.isEmpty) {
      emit(FavouritesError("No token found. Please login again."));
      return;
    }

    try {
      final either = await favouriteRepository.fetchFavourites(token: token);

      either.fold(
            (error) {
          emit(FavouritesError(error.errorMessage));
          print("Favourites Error: ${error.errorMessage}");
        },
            (responses) {
          emit(FavouritesSuccess(responses));
        },
      );
    } catch (e, stack) {
      print("Favourite exception: $e");
      print(stack);
      emit(FavouritesError('Unexpected error: ${e.toString()}'));
    }
  }
}
