import 'package:movie_app/errors/Errors.dart';

import '../../../../Data/models/LoginResponse.dart';

abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}

class LoginErrorStates extends LoginStates {
  Errors error;

  LoginErrorStates({required this.error});
}

class LoginSuccessStates extends LoginStates {
  LoginResponse loginResponse;

  LoginSuccessStates({required this.loginResponse});
}
