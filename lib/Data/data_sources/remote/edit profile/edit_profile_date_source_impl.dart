import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:copy_movie/Data/data_sources/remote/edit%20profile/edit_profile_date_source.dart';
import 'package:copy_movie/Data/models/UserResponse.dart';
import 'package:copy_movie/api/EndPoints.dart';
import 'package:copy_movie/api/apiConstants.dart';
import 'package:copy_movie/api/apiManger.dart';
import 'package:copy_movie/errors/Errors.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

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
  Future<Either<Errors, UserResponse>> updateUser(String token, Map<String, dynamic> data)async {
    try {
      List<ConnectivityResult> results = await Connectivity().checkConnectivity();
      if(results.contains(ConnectivityResult.wifi) || results.contains(ConnectivityResult.mobile)){
        var response = await apiManger.updateUser(
            baseUrl: ApiConstants.AuthBaseUrl,
            endPoint: EndPoints.user,
            token: token,
            body: data
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