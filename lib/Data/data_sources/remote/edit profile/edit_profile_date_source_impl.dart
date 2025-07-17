import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/data_sources/remote/edit%20profile/edit_profile_date_source.dart';
import 'package:movie_app/Data/models/UserResponse.dart';
import 'package:movie_app/api/EndPoints.dart';
import 'package:movie_app/api/apiConstants.dart';
import 'package:movie_app/api/apiManger.dart';
import 'package:movie_app/errors/Errors.dart';

@Injectable(as : EditProfileDataSource)
class EditProfileDataSourceImpl implements EditProfileDataSource{
  ApiManger apiManger;
  EditProfileDataSourceImpl({required this.apiManger});

  /// Get User
  @override
  Future<Either<Errors,UserResponse>> getUser(String token) async{
    try {
      List<ConnectivityResult> results = await Connectivity().checkConnectivity();
      if(results.contains(ConnectivityResult.wifi) || results.contains(ConnectivityResult.mobile)){
        var response = await apiManger.getUser(
            baseUrl: ApiConstants.AuthBaseUrl,
            endPoint: EndPoints.user,
            token: token
        );
        if(response.statusCode! >= 200 && response.statusCode! < 300){
          return Right(UserResponse.fromJson(response.data));
        }else{
          return Left(ServerErrors(errorMessage: response.statusMessage!));
        }
      }else{
        return Left(NetworkErrors(errorMessage: 'No internet connection'));
      }
    } catch (e) {
      return Left(Errors(errorMessage: e.toString()));
    }
  }

  /// Update User
  @override
  Future<Either<Errors, UserResponse>> updateUser(String token,
      Map<String, dynamic> data) async {
    try {
      List<ConnectivityResult> results = await Connectivity().checkConnectivity();
      if (results.contains(ConnectivityResult.wifi) ||
          results.contains(ConnectivityResult.mobile)) {
        var response = await apiManger.updateUser(
          baseUrl: ApiConstants.AuthBaseUrl,
          endPoint: EndPoints.user,
          token: token,
          body: data,
        );

        // ✅ Log full response
        print('UpdateUser response status: ${response.statusCode}');
        print('UpdateUser response body: ${response.data}');

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(UserResponse.fromJson(response.data));
        } else {
          // Try to extract error message from body
          final message = response.data['message'] ?? response.statusMessage ??
              'Update failed';
          return Left(ServerErrors(errorMessage: message));
        }
      } else {
        return Left(NetworkErrors(errorMessage: 'No internet connection'));
      }
    } catch (e) {
      print('Exception during updateUser: $e');
      return Left(Errors(errorMessage: e.toString()));
    }
  }


  /// Delete User
  @override
  Future<Either<Errors, UserResponse>> deleteUser(String token)async {
    try {
      List<ConnectivityResult> results = await Connectivity().checkConnectivity();
      if(results.contains(ConnectivityResult.wifi) || results.contains(ConnectivityResult.mobile)){
        var response = await apiManger.deleteUser(
            baseUrl: ApiConstants.AuthBaseUrl,
            endPoint: EndPoints.user,
            token: token
        );
        if(response.statusCode! >= 200 && response.statusCode! < 300){
          return Right(UserResponse.fromJson(response.data));
        }else{
          return Left(ServerErrors(errorMessage: response.statusMessage!));
        }
      }else{
        return Left(NetworkErrors(errorMessage: 'No internet connection'));
      }
    } catch (e) {
      return Left(Errors(errorMessage: e.toString()));
    }
  }

}