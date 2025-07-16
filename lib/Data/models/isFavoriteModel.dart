class IsFavoriteModel {
  IsFavoriteModel({this.message, this.data});

  IsFavoriteModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
  }

  String? message;
  bool? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = data;
    return map;
  }
}
