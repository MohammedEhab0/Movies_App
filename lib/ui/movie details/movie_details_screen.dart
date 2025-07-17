import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/models/MovieRespone.dart';
import 'package:movie_app/Providers/UserProvider.dart';
import 'package:movie_app/api/apiManger.dart';
import 'package:movie_app/ui/Widgets/movie_card.dart';
import 'package:movie_app/ui/Widgets/movie_play.dart';
import 'package:movie_app/ui/Widgets/summary.dart';
import 'package:movie_app/ui/Widgets/watchBtn_and_screen_shots.dart';
import 'package:movie_app/ui/movie details/favorite_cubit.dart';
import 'package:provider/provider.dart';

import '../Di/di.dart';
import '../homescreen/tabs/home/Cubit/movie_view_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movies movie;
  final List<Movies> similarMovies;

  const MovieDetailsScreen({
    Key? key,
    required this.movie,
    required this.similarMovies,
  }) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final MoviesCubit movieViewModel = getIt<MoviesCubit>();

  List<Movies> _getFilteredSimilarMovies() {
    final mainGenre = widget.movie.genres?.isNotEmpty == true
        ? widget.movie.genres!.first
        : null;

    if (mainGenre == null) return [];

    return widget.similarMovies
        .where((m) =>
    m.genres?.contains(mainGenre) == true &&
        m.id != widget.movie.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSimilarMovies = _getFilteredSimilarMovies();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.currentUser?.token;
    final movieId = widget.movie.id;

    return BlocProvider(
      create: (_) {
        final cubit = FavoriteCubit(ApiManger());
        if (token != null && movieId != null) {
          cubit.checkFavorite(movieId, token);
        }
        return cubit;
      },
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              PlayMovieWidget(movie: widget.movie),
              const SizedBox(height: 16),
              WatchBtnAndScreenShots(movie: widget.movie),
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
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.74,
                  ),
                  itemBuilder: (context, index) {
                    final movieItem = filteredSimilarMovies[index];
                    return MovieCard(
                      movie: movieItem,
                      onPressed: () async {
                        final movieDetails = await movieViewModel
                            .fetchMovieDetails(movieItem.id ?? 0);
                        if (movieDetails != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailsScreen(
                                    movie: movieDetails,
                                    similarMovies: widget.similarMovies,
                                  ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
              SummaryAndCast(movie: widget.movie),
            ],
          ),
        ),
      ),
    );
  }
}
