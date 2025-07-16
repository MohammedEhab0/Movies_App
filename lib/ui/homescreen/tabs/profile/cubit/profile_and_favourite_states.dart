// IMPORTANT: Make sure this import points to the REDEFINED FavouriteModelItem.dart
import 'package:copy_movie/Data/models/FavouriteModelItem.dart'; // This now defines FavouriteItemModel directly
import 'package:copy_movie/Data/models/ProfileModel.dart';

abstract class ProfilesStates {}

class ProfileAndFavouritesLoading extends ProfilesStates {}

class ProfileAndFavouritesSuccess extends ProfilesStates {
  final ProfileModel? profile;

  // Now it's List<FavouriteItemModel>? because FavouriteItemModel is the actual item
  final List<FavouriteItemModel>? favourites;
  final String? profileErrorMessage;
  final String? favouriteErrorMessage;

  ProfileAndFavouritesSuccess({
    this.profile,
    this.favourites,
    this.profileErrorMessage,
    this.favouriteErrorMessage,
  });
}

class ProfileAndFavouritesError extends ProfilesStates {
  final String message;

  ProfileAndFavouritesError(this.message);
}

// Keep your existing individual states if you need them, but they'll use FavouriteItemModel
class ProfilesLoading extends ProfilesStates {}
class ProfilesSuccess extends ProfilesStates {
  final ProfileModel profile;
  ProfilesSuccess(this.profile);
}
class ProfilesError extends ProfilesStates {
  final String message;
  ProfilesError(this.message);
}

class FavouritesLoading extends ProfilesStates {}
class FavouritesSuccess extends ProfilesStates {
  // Now it's List<FavouriteItemModel>
  final List<FavouriteItemModel> favourites;
  FavouritesSuccess(this.favourites);
}
class FavouritesError extends ProfilesStates {
  final String message;
  FavouritesError(this.message);
}