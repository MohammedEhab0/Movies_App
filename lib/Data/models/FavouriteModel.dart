class FavouriteItemModel {
  final String id;
  final String title;
  final String posterPath;

  FavouriteItemModel({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory FavouriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavouriteItemModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'poster_path': posterPath,
    };
  }
}
