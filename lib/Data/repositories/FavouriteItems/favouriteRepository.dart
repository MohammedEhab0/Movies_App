

import 'package:dartz/dartz.dart';

import '../../../errors/Errors.dart';
import '../../models/FavouriteModelItem.dart';

abstract class FavouriteRepository{
  Future<Either<Errors, List<FavouriteItemModel>>> fetchFavourites({required String token});

}