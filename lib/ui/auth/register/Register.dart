import 'package:carousel_slider/carousel_slider.dart';
import 'package:copy_movie/UI/Di/di.dart';
import 'package:copy_movie/UI/auth/register/Cubit/register_view_model.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:copy_movie/utils/app_styles.dart';
import 'package:copy_movie/utils/dialog_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/validators.dart';
import '../../Widgets/CustomElevatedButton.dart';
import '../../Widgets/CustomTextField.dart';
import '../../Widgets/ToggleLanguage.dart';
import '../../homescreen/home_screen.dart';
import '../login/Login.dart';
import 'Cubit/registerStates.dart';


class Register extends StatefulWidget {
  static const routeName = 'Register';

  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterViewModel viewModel = getIt<RegisterViewModel>();
  List<String> avatarList =[AppAssets.character1,
    AppAssets.character2,
    AppAssets.character3,
    AppAssets.character4,
    AppAssets.character5,
    AppAssets.character6,
    AppAssets.character7,
    AppAssets.character8,
    AppAssets.character9,
  ];

  // Initialize avatarId with a default value (e.g., 0 for the first avatar)
  int avatarId = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocListener<RegisterViewModel, RegisterStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is RegisterLoadingStates) {
          DialogUtils.showLoading(context: context, message: "Loading ...");
        } else if (state is RegisterErrorStates) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: state.error.errorMessage,
            title: "Error",
            posActionName: "ok",
          );
          print(state.error.errorMessage);
        } else if (state is RegisterSuccessStates) {
          DialogUtils.hideLoading(context); // Dismiss loading dialog.

          // IMPORTANT: Perform navigation immediately.
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);

          // Now, show a success message on the new screen.
          DialogUtils.showMessage(
            context: context, // Context from the listener
            message: "Register Successfully",
            title: 'Success',
            posActionName: "ok",
            // No posAction for navigation here.
            posAction: () {
              // Dialog will just dismiss itself.
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.blackColor),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'register'.tr(),
            style: AppStyles.regular16yellow,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          // Update avatarId when the page changes
                          setState(() {
                            avatarId = index;
                          });
                        },
                        enlargeFactor: .5,
                        viewportFraction: .381,
                        enlargeCenterPage: true,
                        height: height * .21),
                    items: List.generate(avatarList.length, (index) => index ).map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              margin: const EdgeInsets.symmetric(horizontal: .5),
                              decoration: const BoxDecoration(),
                              child:Image.asset(avatarList[i],fit:BoxFit.fitWidth));
                        },
                      );
                    }).toList(),
                  ),

                  CustomTextField(
                    controller: viewModel.nameController,
                    prefixIcon: Image.asset(AppAssets.nameIcon),
                    hintText: 'name'.tr(),
                    textInputType: TextInputType.name,
                    validator: AppValidators.validateUsername,
                  ),
                  SizedBox(height: height * .02),
                  CustomTextField(
                    controller: viewModel.emailController,
                    prefixIcon: Image.asset(AppAssets.emailIcon),
                    hintText: 'email'.tr(),
                    textInputType: TextInputType.emailAddress,
                    validator: AppValidators.validateEmail,
                  ),
                  SizedBox(height: height * .02),
                  CustomTextField(
                    suffixIcon: Image.asset(AppAssets.eyeIcon),
                    controller: viewModel.passwordController,
                    obscureText: true,
                    prefixIcon: Image.asset(AppAssets.passwordIcon),
                    hintText: 'password'.tr(),
                    textInputType: TextInputType.text,
                    validator: AppValidators.validatePassword,
                  ),
                  SizedBox(height: height * .02),
                  CustomTextField(
                    suffixIcon: Image.asset(AppAssets.eyeIcon),
                    controller: viewModel.confirmPasswordController,
                    obscureText: true,
                    prefixIcon: Image.asset(AppAssets.passwordIcon),
                    hintText: 'Confirm password'.tr(),
                    textInputType: TextInputType.text,
                    validator: (val) => AppValidators.validateConfirmPassword(
                      val,
                      viewModel.passwordController.text,
                    ),
                  ),
                  SizedBox(height: height * .02),
                  CustomTextField(
                    controller: viewModel.phoneController,
                    prefixIcon: Image.asset(AppAssets.phoneIcon),
                    hintText: 'phone'.tr(),
                    textInputType: TextInputType.phone,
                    validator: AppValidators.validatePhoneNumber,
                  ),
                  SizedBox(height: height * .02),
                  CustomElevatedButton(
                    onPressed: () => viewModel.register(avaterId: avatarId), // Pass the updated avatarId
                    textButton: "create account".tr(),
                    bgColor: AppColors.yellowColor,
                  ),
                  SizedBox(height: height * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'already have account'.tr(),
                        style: AppStyles.regular14White,
                      ),
                      TextButton(
                        onPressed: () {
                          // Push to Login, allowing back navigation to Register
                          Navigator.of(context).pushNamed(Login.routeName);
                        },
                        child: Text(
                          'login'.tr(),
                          style: AppStyles.bold14yellow,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .01),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleLanguage(),
                    ],
                  ),SizedBox(height: height * .02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}