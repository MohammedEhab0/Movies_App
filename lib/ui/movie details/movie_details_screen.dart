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
    super.key,
    required this.movie,
    required this.similarMovies,
  });

  @override
  Widget build(BuildContext context) {
    final String? mainGenre = movie.genres?.isNotEmpty == true
        ? movie.genres!.first
        : null;

    final List<Movies> filteredSimilarMovies = similarMovies.where((m) {
      if (mainGenre == null || m.genres == null) return false;
      return m.genres!.contains(mainGenre) && m.id != movie.id;
    }).toList();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: PlayMovieWidget(movie: movie)),
            SliverToBoxAdapter(child: WatchBtnAndScreenShots(movie: movie)),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return MovieCard(
                    movie: filteredSimilarMovies[index],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                            movie: filteredSimilarMovies[index],
                            similarMovies: similarMovies,
                          ),
                        ),
                      );
                    },
                  );
                }, childCount: filteredSimilarMovies.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.74,
                  crossAxisCount: 2,
                ),
              ),
            ),
            SliverToBoxAdapter(child: SummaryAndCast(movie: movie)),
          ],
        ),
      ),
    );
  }
}
