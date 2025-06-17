import 'package:copy_movie/Data/repositories/auth/auth_repository.dart';
import 'package:copy_movie/ui/auth/login/Cubit/loginStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  LoginViewModel({required this.authRepository}) : super(LoginInitialStates());

  AuthRepository authRepository;
  var emailController = TextEditingController(text: 'mo11@mo.com');
  var passwordController = TextEditingController(text: 'Amr2510@');
  var formKey = GlobalKey<FormState>();

  void login() async {
    if (formKey.currentState?.validate() == true) {
      var either = await authRepository.login(
        email: emailController.text,
        password: passwordController.text,
      );

      either.fold(
            (error) => emit(LoginErrorStates(error: error)),
            (response) => emit(LoginSuccessStates(  loginResponse: response,)),
      );
    }
  }
}

