import 'package:copy_movie/Providers/UserProvider.dart';
import 'package:copy_movie/UI/Di/di.dart';
import 'package:copy_movie/UI/Widgets/CustomElevatedButton.dart';
import 'package:copy_movie/UI/auth/login/Login.dart';
import 'package:copy_movie/ui/Widgets/CustomTextField.dart';
import 'package:copy_movie/ui/homescreen/tabs/profile/edit%20profile/cubit/edit_profile_states.dart';
import 'package:copy_movie/ui/homescreen/tabs/profile/edit%20profile/cubit/edit_profile_view_model.dart';
import 'package:copy_movie/utils/app_styles.dart';
import 'package:copy_movie/utils/bottom_sheet.dart';
import 'package:copy_movie/utils/dialog_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_colors.dart';
import '../profile_tab.dart';

class EditProfile extends StatefulWidget {
  static String routeName = 'updateProfile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileViewModel viewModel = getIt<EditProfileViewModel>();

  int? selectedAvatar;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    print(userProvider.currentUser!.token);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Edit profile'.tr(), style: AppStyles.regular16yellow),
          centerTitle: true,
        ),
        body: BlocConsumer<EditProfileViewModel, UpdateProfileStates>(
          bloc: viewModel..getUser(userProvider.currentUser!.token),
          listener: (context, state) {
            if (state is UpdateProfileUpdateActionState) {
              return DialogUtils.showMessage(
                context: context,
                message: state.message,
                posActionName: 'ok',
                posAction: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushReplacementNamed(
                      ProfileTab.routeName,


                    );
                  });
                },
              );
            } else if (state is UpdateProfileDeleteActionState) {
              return DialogUtils.showMessage(
                context: context,
                message: state.message,
                posActionName: 'Ok',
                posAction: () {
                  Navigator.of(context).pop();
                  Future.delayed(Duration.zero, () {
                    userProvider.logout();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Login.routeName,
                          (route) => false,
                    );
                  });
                },
              );
            }
          },
          builder: (context, state) {
            if (state is UpdateProfileSuccessState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showAvatarBottomSheet(
                            context,
                            selectedAvatar ?? state.userData.avaterId as int,
                                (avatarNumber) {
                              setState(() {
                                selectedAvatar = avatarNumber;
                              });
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.transparentColor,
                          backgroundImage: AssetImage(
                            viewModel.avatarList[
                            selectedAvatar ?? state.userData.avaterId as int],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        isFilled: true,
                        fillColor: AppColors.lightBlack,
                        controller: viewModel.nameController =
                            TextEditingController(text: state.userData.name),
                        prefixIcon: Icon(Icons.person),
                        colorBorder: AppColors.transparentColor,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        isFilled: true,
                        fillColor: AppColors.lightBlack,
                        controller: viewModel.phoneController =
                            TextEditingController(text: state.userData.phone),
                        prefixIcon: Icon(Icons.phone),
                        colorBorder: AppColors.transparentColor,
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'reset password'.tr(),
                          style: AppStyles.regular16white,
                        ),
                      ),
                      const SizedBox(height: 100), // replaces Spacer
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          textButton: 'Delete Account'.tr(),
                          bgColor: AppColors.redColor,
                          textColor: AppColors.whiteColor,
                          onPressed: () {
                            viewModel.deleteUser(
                                token: userProvider.currentUser!.token);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          textButton: 'Update Date'.tr(),
                          bgColor: AppColors.yellowColor,
                          textColor: AppColors.blackColor,
                          onPressed: () {
                            viewModel.updateUser(
                              token: userProvider.currentUser!.token,
                              data: {
                                "name": viewModel.nameController.text.trim(),
                                "phone": viewModel.phoneController.text.trim(),
                                "avaterId": selectedAvatar ??
                                    state.userData.avaterId,
                              },
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              );
            } else if (state is UpdateProfileErrorState) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: AppStyles.regular20White,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: AppColors.yellowColor),
              );
            }
          },
        ),
      ),
    );
  }
}
