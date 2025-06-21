import 'package:copy_movie/Data/models/ProfileModel.dart';
import 'package:copy_movie/Data/models/FavouriteModel.dart';

abstract class ProfilesStates {}

// Profile states
class ProfilesLoading extends ProfilesStates {}

class ProfilesSuccess extends ProfilesStates {
  final ProfileModel profile;

  ProfilesSuccess(this.profile);
}

class ProfilesError extends ProfilesStates {
  final String message;

  ProfilesError(this.message);
}

// Favourites (Watch List) states
class FavouritesLoading extends ProfilesStates {}

class FavouritesSuccess extends ProfilesStates {
  final List<FavouriteItemModel> favourites;

  FavouritesSuccess(this.favourites);
}

class FavouritesError extends ProfilesStates {
  final String message;

  FavouritesError(this.message);
}
