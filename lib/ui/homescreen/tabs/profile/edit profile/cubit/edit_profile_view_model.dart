import 'package:copy_movie/Data/repositories/edit%20profile/edit_profile_repository.dart';
import 'package:copy_movie/ui/homescreen/tabs/profile/edit%20profile/cubit/edit_profile_states.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileViewModel extends Cubit<UpdateProfileStates> {
  late EditProfileRepository repository;
  EditProfileViewModel({required this.repository})
    : super(UpdateProfileLoadingState());

  List<String> avatarList = [
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
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  /// get user
  void getUser(String token) async {
    emit(UpdateProfileLoadingState());
    var either = await repository.getUser(token);
    either.fold(
      (error) => emit(UpdateProfileErrorState(errorMessage: error.errorMessage)),
      (response) => emit(UpdateProfileSuccessState(userData: response.data!)),
    );
  }

  /// update user
  void updateUser(
      {required String token, required Map<String, dynamic> data}) async {
    emit(UpdateProfileLoadingState());

    debugPrint('🔼 Sending updateUser payload: $data');

    var either = await repository.updateUser(token, data);
    either.fold(
          (error) {
        debugPrint('❌ Update failed: ${error.errorMessage}');
        emit(UpdateProfileErrorState(errorMessage: error.errorMessage));
      },
          (response) {
        debugPrint('✅ Update successful: ${response.message}');
        emit(UpdateProfileUpdateActionState(message: response.message!));
      },
    );
  }


  /// delete user
  void deleteUser({required String token})async {
    emit(UpdateProfileLoadingState());
    var either = await repository.deleteUser(token);
    either.fold(
      (error) => emit(UpdateProfileErrorState(errorMessage: error.errorMessage)),
      (response) => emit(UpdateProfileDeleteActionState(message: response.message!)),
    );
  }

  /// Bottom sheet
}
