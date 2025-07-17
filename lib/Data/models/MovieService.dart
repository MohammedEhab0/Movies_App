import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/Data/models/MovieRespone.dart';
import 'package:movie_app/api/apiConstants.dart';

class MovieService {
  static Future<List<Movies>> fetchMovies() async {
    final response = await http.get(
      Uri.parse("${ApiConstants.moviesBaseUrl}/list_movies.json"),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = MoviesResponse.fromJson(json);
      return data.data?.movies ?? [];
    } else {
      throw Exception("Failed to load movies");
    }
  }

  static Future<Movies?> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse(
        "${ApiConstants.moviesBaseUrl}/movie_details.json?movie_id=$movieId",
      ),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = MoviesResponse.fromJson(json);
      return data.data?.movies?.first;
    } else {
      throw Exception("Failed to load movie details");
    }
  }
}
