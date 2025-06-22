
import 'package:copy_movie/Data/models/ProfileModel.dart';
import 'package:copy_movie/errors/Errors.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRemoteDataSource {
 Future<Either<Errors, ProfileModel>> getProfile(String token);
}
