import 'package:copy_movie/Data/data_sources/remote/auth_remote_data_source.dart';
import 'package:copy_movie/Data/models/LoginResponse.dart';
import 'package:copy_movie/Data/models/registerResponse.dart';
import 'package:copy_movie/Data/repositories/auth/auth_repository.dart';
import 'package:copy_movie/errors/Errors.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Errors, RegisterResponse>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId, // stay as String
  }) async {
    var either = await authRemoteDataSource.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      avaterId: avaterId,
    );
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Errors, LoginResponse>> login(
      {required String email, required String password}) async {
    var either =
        await authRemoteDataSource.login(email: email, password: password);
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
