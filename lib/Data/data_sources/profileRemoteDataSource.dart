import 'package:dartz/dartz.dart';
import 'package:movie_app/Data/models/ProfileModel.dart';
import 'package:movie_app/errors/Errors.dart';

abstract class ProfileRemoteDataSource {
 Future<Either<Errors, ProfileModel>> getProfile(String token);
}
