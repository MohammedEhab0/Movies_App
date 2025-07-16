// This file will now define a single class that represents a favorite item directly.

class FavouriteItemModel {
  // Renamed from FavouriteModelItem to FavouriteItemModel for clarity
  FavouriteItemModel({
    // Constructor
    this.movieId,
    this.name,
    this.rating,
    this.imageURL,
    this.year,
  });

  FavouriteItemModel.fromJson(dynamic json) {
    // Factory constructor for JSON
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }

  String? movieId; // This will hold the ID
  String? name; // This will hold the movie name/title
  double? rating;
  String? imageURL; // This will hold the poster URL
  String? year;

  Map<String, dynamic> toJson() {
    // For serialization back to JSON if needed
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }
}

// You can REMOVE the 'Data' class entirely from this file now.
// It's no longer needed as FavouriteItemModel directly holds the movie data.
