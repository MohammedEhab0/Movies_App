import 'package:copy_movie/Data/models/FavouriteModel.dart';
import 'package:copy_movie/errors/Errors.dart';
import 'package:dartz/dartz.dart';

abstract class FavouriteRemoteDataSource {
  Future<Either<Errors, List<FavouriteItemModel>>> getFavourites({required String token});
}
