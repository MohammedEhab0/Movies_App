import 'package:dartz/dartz.dart';
import 'package:movie_app/Data/models/UserResponse.dart';
import 'package:movie_app/errors/Errors.dart';

abstract class EditProfileRepository {
  /// get user
  Future<Either<Errors, UserResponse>> getUser(String token);

  /// update user
  Future<Either<Errors, UserResponse>> updateUser(String token, Map<String, dynamic> data,);

  /// delete user
  Future<Either<Errors, UserResponse>> deleteUser(String token);


}