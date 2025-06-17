import 'package:copy_movie/UI/auth/login/Cubit/login_view_model.dart';
import 'package:copy_movie/UI/auth/register/Register.dart';
import 'package:copy_movie/UI/homescreen/home_screen.dart';
import 'package:copy_movie/ui/auth/login/Cubit/loginStates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/validators.dart';
import '../../Di/di.dart';
import '../../Widgets/CustomElevatedButton.dart';
import '../../Widgets/CustomTextField.dart';
import '../../Widgets/ToggleLanguage.dart';

class Login extends StatefulWidget {
  static const routeName = 'Login';

  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginViewModel viewModel = getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<LoginViewModel, LoginStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is LoginLoadingStates) {
          DialogUtils.showLoading(context: context, message: "Loading ...");
        } else if (state is LoginErrorStates) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: state.error.errorMessage,
            title: "Error",
            posActionName: "ok",
          );
          print(state.error.errorMessage);
        } else if (state is LoginSuccessStates) {
          DialogUtils.hideLoading(context); // Dismiss the loading dialog first.

          // IMPORTANT: Perform navigation immediately after dismissing loading.
          // This ensures the current 'context' is still valid for navigation.
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);

          // Now, show a success message *after* navigation has been initiated.
          // This dialog will appear on top of the HomeScreen.
          // We can remove the posAction here as navigation already occurred.
          DialogUtils.showMessage(
            context: context, // This 'context' is still valid as it's from the listener
            message: "Login Successfully",
            title: 'Success',
            posActionName: "ok",
            // No posAction needed here as navigation has already happened.
            // The dialog will just dismiss itself on "ok".
            posAction: () {
              // Optionally, if you wanted to do something else after dialog close,
              // but for navigation, it's already done.
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
            'login'.tr(),
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
                  SizedBox(height: height * .05),
                  SizedBox(
                    height: height * .23,
                    child: Image.asset(AppAssets.logoSplash),
                  ),
                  SizedBox(height: height * .05),
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
                  CustomElevatedButton(
                    onPressed: () => viewModel.login(),
                    textButton: "login".tr(),
                    bgColor: AppColors.yellowColor,
                  ),
                  SizedBox(height: height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do not have account'.tr(),
                        style: AppStyles.regular14White,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Register.routeName);
                        },
                        child: Text(
                          'register'.tr(),
                          style: AppStyles.bold14yellow,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .02),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleLanguage(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}