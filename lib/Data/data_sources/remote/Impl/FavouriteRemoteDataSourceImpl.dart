import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/models/FavouriteModelItem.dart';
import 'package:movie_app/errors/Errors.dart';

import '../../../../api/EndPoints.dart';
import '../../../../api/apiConstants.dart';
import '../../../../api/apiManger.dart';
import '../FavouriteRemoteDataSource.dart';

@Injectable(as: FavouriteRemoteDataSource)
class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  final ApiManger apiManger;

  FavouriteRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Either<Errors, List<FavouriteItemModel>>> getFavourites({required String token}) async {
    try {
      final response = await apiManger.getData(
        baseUrl: ApiConstants.FavouriteItemsBaseUrl,
        endPoint: EndPoints.favourite,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["data"];
        final favourites = data
            .map((item) => FavouriteItemModel.fromJson(item))
            .toList();
        return Right(favourites);
      } else {
        final message = response.data["message"] ?? "Unknown server error";
        return Left(ServerErrors(errorMessage: message));
      }
    } catch (e, stackTrace) {
      print("FavouriteRemoteDataSource error: $e");
      print(stackTrace);
      return Left(NetworkErrors(errorMessage: 'Network error: ${e.toString()}'));
    }
  }
}
