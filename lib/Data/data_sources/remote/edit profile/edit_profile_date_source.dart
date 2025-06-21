import 'package:copy_movie/Data/models/UserResponse.dart';
import 'package:copy_movie/errors/Errors.dart';
import 'package:dartz/dartz.dart';

abstract class EditProfileDataSource {
  /// get user
  Future<Either<Errors, UserResponse>> getUser(String token);

  /// update user
  Future<Either<Errors, UserResponse>> updateUser(String token, Map<String, dynamic> data,);

  /// delete user
  Future<Either<Errors, UserResponse>> deleteUser(String token);
}
