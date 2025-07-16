class AddToFavorite {
  AddToFavorite({this.statusCode, this.message, this.data});

  AddToFavorite.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  int? statusCode;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({this.movieId, this.name, this.rating, this.imageURL, this.year});

  Data.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = (json['rating'] as num?)?.toDouble();
    imageURL = json['imageURL'];
    year = json['year'];
  }

  String? movieId;
  String? name;
  double? rating;
  String? imageURL;
  String? year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }
}
