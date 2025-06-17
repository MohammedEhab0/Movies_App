class LoginResponse {
  LoginResponse({
    this.type,
    this.properties,
    this.statusCode, // Added for error responses
    this.message,    // Added for error responses
  });

  LoginResponse.fromJson(dynamic json) {
    type = json['type'];
    properties = json['properties'] != null ? Properties.fromJson(json['properties']) : null;
    // Check for error fields
    statusCode = json['statusCode'];
    message = json['message'];
  }

  String? type;
  Properties? properties;
  int? statusCode; // Nullable for successful responses
  String? message; // Nullable for successful responses

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    // Include error fields if they exist
    if (statusCode != null) {
      map['statusCode'] = statusCode;
    }
    if (message != null) {
      map['message'] = message;
    }
    return map;
  }
}

class Properties {
  Properties({
    this.message,
    this.data,
  });

  Properties.fromJson(dynamic json) {
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Message? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (message != null) {
      map['message'] = message?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.type,
  });

  Data.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }
}

class Message {
  Message({
    this.type,
  });

  Message.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }
}