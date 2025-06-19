class Cast {
  final String? name;
  final String? characterName;
  final String? image;

  Cast({this.name, this.characterName, this.image});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'],
      characterName: json['character_name'],
      image: json['url_small_image'],
    );
  }
}
