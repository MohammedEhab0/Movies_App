class LoginResponse {
  LoginResponse({
    this.data,
    this.message,
    this.statusCode,
    this.error,
  });

  LoginResponse.fromJson(dynamic json) {
    data = json['data'];
    message = json['message'];
    statusCode = json['statusCode'];
    error = json['error'];
  }

  String? data;
  dynamic message; // can be a string or list
  int? statusCode;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['message'] = message;
    map['statusCode'] = statusCode;
    map['error'] = error;
    return map;
  }

  String get displayMessage {
    if (message is List) {
      return (message as List).join('\n');
    } else if (message is String) {
      return message!;
    }
    return '';
  }
}
