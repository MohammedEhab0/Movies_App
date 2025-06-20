import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/ui/Widgets/movie_card.dart';
import 'package:copy_movie/ui/Widgets/movie_play.dart';
import 'package:copy_movie/ui/Widgets/summary.dart';
import 'package:copy_movie/ui/Widgets/watchBtn_and_screen_shots.dart';
import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movies movie;
  final List<Movies> similarMovies;

  const MovieDetailsScreen({
    Key? key,
    required this.movie,
    required this.similarMovies,
  }) : super(key: key);

  List<Movies> _getFilteredSimilarMovies() {
    final mainGenre = movie.genres?.isNotEmpty == true
        ? movie.genres!.first
        : null;
    if (mainGenre == null) return [];
    return similarMovies
        .where((m) => m.genres?.contains(mainGenre) == true && m.id != movie.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSimilarMovies = _getFilteredSimilarMovies();

    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            PlayMovieWidget(movie: movie),
            const SizedBox(height: 16),
            WatchBtnAndScreenShots(movie: movie),
            const SizedBox(height: 16),
            if (filteredSimilarMovies.isNotEmpty) ...[
              const Text(
                'Similar Movies',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredSimilarMovies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.74,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final movieItem = filteredSimilarMovies[index];
                  return MovieCard(
                    movie: movieItem,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                            movie: movieItem,
                            similarMovies: similarMovies,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
            SummaryAndCast(movie: movie),
          ],
        ),
      ),
    );
  }
}
