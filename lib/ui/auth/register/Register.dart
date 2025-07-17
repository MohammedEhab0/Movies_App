import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // ✅ Correct
import 'package:movie_app/Data/data_sources/remote/Impl/auth_remote_daraSource_impl.dart';
import 'package:movie_app/Data/data_sources/remote/auth_remote_data_source.dart';
import 'package:movie_app/Data/repositories/auth/auth_repository.dart';
import 'package:movie_app/Data/repositories/auth/auth_repository_impl.dart';
import 'package:movie_app/api/apiManger.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/dialog_utils.dart';

import '../../../utils/validators.dart';
import '../../Widgets/CustomElevatedButton.dart';
import '../../Widgets/CustomTextField.dart';
import '../../Widgets/ToggleLanguage.dart';
import '../login/Login.dart';
import 'Cubit/registerStates.dart';
import 'Cubit/register_view_model.dart';

class Register extends StatefulWidget {
  static const routeName = 'Register';

  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // 1. Declare viewModel as a late class member
  late SignUpViewModel viewModel;

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

  @override
  void initState() {
    // 2. Initialize the class member viewModel
    ApiManger apiManger = ApiManger();
    AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceImpl(apiManger: apiManger);
    AuthRepository authRepository = AuthRepositoryImpl(authRemoteDataSource: authRemoteDataSource);
    viewModel = SignUpViewModel(authRepository: authRepository); // Assign to the class member
    super.initState();
  }

  int avatarId = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocListener<SignUpViewModel, RegisterStates>(
      bloc: viewModel, // Now 'viewModel' is correctly defined in this scope
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
        } else if (state is RegisterSuccessStates) {
          DialogUtils.hideLoading(context);
          Navigator.pushReplacementNamed(context, Login.routeName);
          DialogUtils.showMessage(
            context: context,
            message: "Register Successfully",
            title: 'Success',
            posActionName: "ok",
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
                        setState(() {
                          avatarId = index;
                        });
                      },
                      enlargeFactor: .5,
                      viewportFraction: .381,
                      enlargeCenterPage: true,
                      height: height * .21,
                    ),
                    items: avatarList.map((avatar) {
                      return Builder(
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: .5),
                            child: Image.asset(avatar, fit: BoxFit.fitWidth),
                          );
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
                    onPressed: () => viewModel.register(avaterId: avatarId),
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
                    children: [ToggleLanguage()],
                  ),
                  SizedBox(height: height * .02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}