import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Data/data_sources/remote/auth_remote_data_source.dart';
import 'package:movie_app/Data/models/LoginResponse.dart';
import 'package:movie_app/Data/models/registerResponse.dart';
import 'package:movie_app/api/EndPoints.dart';
import 'package:movie_app/api/apiConstants.dart';
import 'package:movie_app/api/apiManger.dart';
import 'package:movie_app/errors/Errors.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManger apiManger;

  AuthRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Either<Errors, RegisterResponse>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    try {
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.wifi) || connectivityResult.contains(ConnectivityResult.mobile)) {
        print({
          "name": name,
          "email": email,
          "password": "********", // Mask password for logging
          "confirmPassword": "********", // Mask confirmPassword for logging
          "phone": phone,
          "avaterId": avaterId,
        });

        var response = await apiManger.postData(
          baseUrl: ApiConstants.AuthBaseUrl,
          endPoint: EndPoints.signUp,
          body: {
            "name": name,
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword,
            "phone": phone,
            "avaterId": avaterId,
          },
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          var registerResponse = RegisterResponse.fromJson(response.data);
          return Right(registerResponse);
        } else {
          String errorMessage = response.statusMessage ?? 'An unknown server error occurred.';

          if (response.data is Map) {
            // --- MODIFICATION FOR 'message' AS A LIST STARTS HERE ---
            if (response.data!.containsKey('message')) {
              var messageValue = response.data!['message'];
              if (messageValue is String) {
                errorMessage = messageValue;
              } else if (messageValue is List) {
                // Join list elements if 'message' is a list
                errorMessage = (messageValue).map((e) => e.toString()).join(', ');
              }
              // If 'message' is neither String nor List, you might decide to ignore it
              // or convert to string directly: errorMessage = messageValue.toString();
            }
            // --- MODIFICATION FOR 'message' AS A LIST ENDS HERE ---

            // Original checks for 'errors' key remain, in case the API uses it for other errors
            else if (response.data!.containsKey('errors') && response.data!['errors'] is List) {
              errorMessage = (response.data!['errors'] as List<dynamic>).map((e) => e.toString()).join(', ');
            } else if (response.data!.containsKey('errors') && response.data!['errors'] is Map) {
              Map<String, dynamic> errorsMap = response.data!['errors'];
              List<String> fieldErrors = [];
              errorsMap.forEach((key, value) {
                if (value is List) {
                  fieldErrors.add('$key: ${(value).map((e) => e.toString()).join(', ')}');
                } else {
                  fieldErrors.add('$key: ${value.toString()}');
                }
              });
              errorMessage = fieldErrors.join('; ');
            }
          }

          print('API Error Response Data for SignUp (${response.statusCode}): ${response.data}');

          return Left(ServerErrors(errorMessage: errorMessage));
        }
      } else {
        return Left(NetworkErrors(errorMessage: 'No internet connection. Please check your connection.'));
      }
    } catch (e) {
      print('Exception during register API call: $e');

      String catchErrorMessage = 'An unexpected error occurred.';
      if (e is List) {
        catchErrorMessage = 'Data format error: ${(e).map((item) => item.toString()).join(', ')}';
      } else {
        catchErrorMessage = 'An unexpected error occurred: ${e.toString()}';
      }
      return Left(Errors(errorMessage: catchErrorMessage));
    }
  }

  @override
  Future<Either<Errors, LoginResponse>> login({required String email, required String password}) async {
    try {
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.wifi) || connectivityResult.contains(ConnectivityResult.mobile)) {
        print({
          "email": email,
          "password": "********", // Mask password for logging
        });
        var response = await apiManger.postData(
          baseUrl: ApiConstants.AuthBaseUrl,
          endPoint: EndPoints.signIn,
          body: {
            "email": email,
            "password": password,
          },
        );

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          var loginResponse = LoginResponse.fromJson(response.data);
          return Right(loginResponse);
        } else {
          String errorMessage = response.statusMessage ?? 'An unknown server error occurred.';

          if (response.data is Map) {
            // --- MODIFICATION FOR 'message' AS A LIST STARTS HERE ---
            if (response.data!.containsKey('message')) {
              var messageValue = response.data!['message'];
              if (messageValue is String) {
                errorMessage = messageValue;
              } else if (messageValue is List) {
                errorMessage = (messageValue).map((e) => e.toString()).join(', ');
              }
            }
            // --- MODIFICATION FOR 'message' AS A LIST ENDS HERE ---

            else if (response.data!.containsKey('errors') && response.data!['errors'] is List) {
              errorMessage = (response.data!['errors'] as List<dynamic>).map((e) => e.toString()).join(', ');
            } else if (response.data!.containsKey('errors') && response.data!['errors'] is Map) {
              Map<String, dynamic> errorsMap = response.data!['errors'];
              List<String> fieldErrors = [];
              errorsMap.forEach((key, value) {
                if (value is List) {
                  fieldErrors.add('$key: ${(value).map((e) => e.toString()).join(', ')}');
                } else {
                  fieldErrors.add('$key: ${value.toString()}');
                }
              });
              errorMessage = fieldErrors.join('; ');
            }
          }

          print('API Error Response Data for SignIn (${response.statusCode}): ${response.data}');

          return Left(ServerErrors(errorMessage: errorMessage));
        }
      } else {
        return Left(NetworkErrors(errorMessage: 'No internet connection. Please check your connection.'));
      }
    } catch (e) {
      print('Exception during login API call: $e');
      String catchErrorMessage = 'An unexpected error occurred.';
      if (e is List) {
        catchErrorMessage = 'Data format error: ${(e).map((item) => item.toString()).join(', ')}';
      } else {
        catchErrorMessage = 'An unexpected error occurred: ${e.toString()}';
      }
      return Left(Errors(errorMessage: catchErrorMessage));
    }
  }
}