class UserResponse {
  UserResponse({
      this.message, 
      this.data,
      this.error,
      this.statusCode,});

  UserResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? UserDataResponse.fromJson(json['data']) : null;
    error = json['error'];
    statusCode = json['statusCode'];
  }
  String? message;
  UserDataResponse? data;
  String? error;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['error'] = error;
    map['statusCode'] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class UserDataResponse {
  UserDataResponse({
      this.id, 
      this.email, 
      this.password, 
      this.name, 
      this.phone, 
      this.avaterId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  UserDataResponse.fromJson(dynamic json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? email;
  String? password;
  String? name;
  String? phone;
  num? avaterId;
  String? createdAt;
  String? updatedAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}