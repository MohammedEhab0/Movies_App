import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/models/FavouriteModelItem.dart';
import 'package:movie_app/errors/Errors.dart';

import '../../data_sources/remote/FavouriteRemoteDataSource.dart';
import 'favouriteRepository.dart';

@Injectable(as: FavouriteRepository)
class FavouriteRepositoryImpl implements FavouriteRepository {
  final FavouriteRemoteDataSource remoteDataSource;

  FavouriteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Errors, List<FavouriteItemModel>>> fetchFavourites({required String token}) async {
    final either = await remoteDataSource.getFavourites(token: token);
    return either.fold(
          (error) => Left(error),
          (response) => Right(response),
    );
  }
}
