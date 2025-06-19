import 'dart:convert';
import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:http/http.dart' as http;

Future<Movies?> fetchMovieDetails(int movieId) async {
  final response = await http.get(
    Uri.parse(
      "https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_cast=true",
    ),
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final movieJson = jsonData['data']['movie'];
    return Movies.fromJson(movieJson);
  } else {
    print("Error");
    return null;
  }
}
