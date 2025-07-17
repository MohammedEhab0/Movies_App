import 'package:dartz/dartz.dart';
import 'package:movie_app/Data/models/FavouriteModelItem.dart';
import 'package:movie_app/errors/Errors.dart';

abstract class FavouriteRemoteDataSource {
  Future<Either<Errors, List<FavouriteItemModel>>> getFavourites({required String token});
}
