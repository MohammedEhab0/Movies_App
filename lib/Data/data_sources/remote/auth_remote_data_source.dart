import 'package:copy_movie/Data/models/LoginResponse.dart';
import 'package:dartz/dartz.dart';

import '../../../errors/Errors.dart';
import '../../models/registerResponse.dart';

abstract class AuthRemoteDataSource{
  Future<Either<Errors, RegisterResponse>> register({required String name, required String email, required String password, required String confirmPassword, required String phone, required int avaterId}) ;

  Future<Either<Errors, LoginResponse>> login({ required String email, required String password}) ;

}