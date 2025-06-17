class RegisterResponse {
  final dynamic message; // Can be String or List
  final UserData? data;

  RegisterResponse({required this.message, this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}


class UserData {
  final String email;
  final String name;
  final String phone;
  final int avaterId;
  final String id;

  UserData({
    required this.email,
    required this.name,
    required this.phone,
    required this.avaterId,
    required this.id,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      avaterId: json['avaterId'],
      id: json['_id'],
    );
  }
}
