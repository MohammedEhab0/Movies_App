import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:copy_movie/Data/models/FavouriteModel.dart';
import '../../../../api/EndPoints.dart';
import '../../../../api/apiConstants.dart';
import '../../../../api/apiManger.dart';
import '../../../../errors/Errors.dart';
import '../FavouriteRemoteDataSource.dart';

@Injectable(as: FavouriteRemoteDataSource)
class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  final ApiManger apiManger;

  FavouriteRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Either<Errors, List<FavouriteItemModel>>> getFavourites({required String token}) async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.mobile &&
          connectivity != ConnectivityResult.wifi) {
        return Left(NetworkErrors(errorMessage: 'No internet connection.'));
      }

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
    } catch (e) {
      return Left(NetworkErrors(errorMessage: 'Network error: ${e.toString()}'));
    }
  }
}
