import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/data_sources/remote/edit%20profile/edit_profile_date_source.dart';
import 'package:movie_app/Data/models/UserResponse.dart';
import 'package:movie_app/Data/repositories/edit%20profile/edit_profile_repository.dart';
import 'package:movie_app/errors/Errors.dart';

@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository{
  EditProfileDataSource dataSource;
  EditProfileRepositoryImpl({required this.dataSource});

  /// Get user
  @override
  Future<Either<Errors, UserResponse>> getUser(String token)async {
    var either = await dataSource.getUser(token);
    return either.fold(
            (error) => Left(error),
            (response) => Right(response));
  }

  /// Update user
  @override
  Future<Either<Errors, UserResponse>> updateUser(String token, Map<String, dynamic> data)async {
    var either = await dataSource.updateUser(token, data);
    return either.fold(
            (error) => Left(error),
            (response) => Right(response));
  }

  /// Delete user
  @override
  Future<Either<Errors, UserResponse>> deleteUser(String token)async {
    var either = await dataSource.deleteUser(token);
    return either.fold(
            (error) => Left(error),
            (response) => Right(response));
  }
}