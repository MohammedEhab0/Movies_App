

import 'package:dartz/dartz.dart';

import '../../../errors/Errors.dart';
import '../../models/FavouriteModel.dart';

abstract class FavouriteRepository{
  Future<Either<Errors, List<FavouriteItemModel>>> fetchFavourites({required String token});

}