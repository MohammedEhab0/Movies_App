import 'package:copy_movie/Data/models/registerResponse.dart';
import 'package:copy_movie/errors/Errors.dart';

abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates {}

class RegisterLoadingStates extends RegisterStates {}

class RegisterErrorStates extends RegisterStates {
  Errors error;

  RegisterErrorStates({required this.error});
}

class RegisterSuccessStates extends RegisterStates {
  RegisterResponse registerResponse;

  RegisterSuccessStates({required this.registerResponse});
}
