import 'package:copy_movie/Data/models/ProfileModel.dart';
import 'package:copy_movie/Data/repositories/getProfile/ProfileRepository.dart';
import 'package:copy_movie/errors/Errors.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data_sources/profileRemoteDataSource.dart';


@Injectable(as: ProfileRepository)

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Errors, ProfileModel>> fetchProfile(String token) async {
    return  remoteDataSource.getProfile(token);
  }
}
