

import 'package:dartz/dartz.dart';

import '../../../errors/Errors.dart';
import '../../models/ProfileModel.dart';

abstract class ProfileRepository{
  Future<Either<Errors, ProfileModel>> fetchProfile(String token);

}