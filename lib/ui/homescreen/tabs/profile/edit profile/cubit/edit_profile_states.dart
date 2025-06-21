import 'package:copy_movie/Data/models/UserResponse.dart';

class UpdateProfileStates {}

class UpdateProfileLoadingState extends UpdateProfileStates {}

class UpdateProfileErrorState extends UpdateProfileStates {
  String errorMessage;
  UpdateProfileErrorState({required this.errorMessage});
}

class UpdateProfileSuccessState extends UpdateProfileStates {
  UserDataResponse userData;
  UpdateProfileSuccessState({required this.userData});
}

class UpdateProfileUpdateActionState extends UpdateProfileStates {
  String message;
  UpdateProfileUpdateActionState({required this.message});
}

class UpdateProfileDeleteActionState extends UpdateProfileStates {
  String message;
  UpdateProfileDeleteActionState({required this.message});
}

class UpdateProfileShowBottomSheetState extends UpdateProfileStates {}