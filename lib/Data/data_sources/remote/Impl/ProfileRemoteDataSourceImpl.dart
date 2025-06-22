import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api/apiManger.dart';
import '../../../../errors/Errors.dart';
import '../../../models/ProfileModel.dart';
import '../../profileRemoteDataSource.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiManger apiManger;

  ProfileRemoteDataSourceImpl(this.apiManger);

  @override
  Future<Either<Errors, ProfileModel>> getProfile(String token) async {
    try {
      final response = await apiManger.getData(
        baseUrl: "https://route-movie-apis.vercel.app",
        endPoint: "/profile",
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final profile = ProfileModel.fromJson(response.data);
        return right(profile);
      } else {
        return left(ServerErrors(
          errorMessage: response.data["message"] ?? "Unknown server error",
        ));
      }
    } catch (e) {
      return left(NetworkErrors(
        errorMessage: "Network error: ${e.toString()}",
      ));
    }
  }
}
