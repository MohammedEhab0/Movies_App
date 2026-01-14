import 'package:copy_movie/Data/repositories/auth/auth_repository.dart';
import 'package:copy_movie/ui/auth/login/Cubit/loginStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../Data/models/MyUser.dart';
import '../../../../Providers/UserProvider.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final AuthRepository authRepository;
  final UserProvider userProvider;

  LoginViewModel({
    required this.authRepository,
    required this.userProvider,
  }) : super(LoginInitialStates());

  var emailController = TextEditingController(text: 'mo11@mo.com');
  var passwordController = TextEditingController(text: 'Amr2510@');
  var formKey = GlobalKey<FormState>();

  void login() async {
    if (formKey.currentState?.validate() == true) {
      emit(LoginLoadingStates());

      final either = await authRepository.login(
        email: emailController.text,
        password: passwordController.text,
      );

      either.fold(
            (error) => emit(LoginErrorStates(error: error)),
            (response) {
          // ✅ Match new API structure
          print('📦 Login token from response: ${response.data}');

          final user = MyUser.fromLoginResponse(response);
          userProvider.updateUser(user);

          emit(LoginSuccessStates(loginResponse: response));
        },
      );
    }
  }

}
