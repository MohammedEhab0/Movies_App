import 'LoginResponse.dart';

class MyUser {
  static const String collectionName = 'MyUser';

  final String token;

  MyUser({required this.token});

  factory MyUser.fromLoginResponse(LoginResponse response) {
    final token = response.data ?? '';
    print('📦 MyUser extracted token: $token');
    return MyUser(token: token);
  }
}
