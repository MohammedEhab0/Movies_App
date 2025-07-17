import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/models/MovieRespone.dart';
import 'package:movie_app/ui/movie details/favorite_cubit.dart';
import 'package:movie_app/ui/movie%20details/favorite_state.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Providers/UserProvider.dart';

class PlayMovieWidget extends StatefulWidget {
  final Movies movie;

  const PlayMovieWidget({super.key, required this.movie});

  @override
  State<PlayMovieWidget> createState() => _PlayMovieWidgetState();
}

class _PlayMovieWidgetState extends State<PlayMovieWidget> {
  bool _didFetchFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didFetchFavorite) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.currentUser?.token;
      final movieId = widget.movie.id;

      if (token != null && movieId != null) {
        context.read<FavoriteCubit>().checkFavorite(movieId, token);
        _didFetchFavorite = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final hasTrailer = widget.movie.ytTrailerCode?.isNotEmpty == true;
    final videoId = YoutubePlayer.convertUrlToId(
        "https://www.youtube.com/watch?v=${widget.movie.ytTrailerCode}");
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        if (hasTrailer && videoId != null)
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
            ),
            width: width,
            showVideoProgressIndicator: true,
          )
        else
          Image.network(
            widget.movie.largeCoverImage ?? '',
            height: height * 0.5,
            width: width,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: height * 0.5,
              width: width,
              color: Colors.grey,
              child: const Center(
                child: Text(
                    "Video not found", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        Container(
          height: height * 0.5,
          width: width,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.03),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.6),
                Colors.black,
              ],
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(color: Colors.white),
                  BlocBuilder<FavoriteCubit, FavoriteState>(
                    builder: (context, state) {
                      if (state is FavoriteLoading) {
                        return const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        );
                      } else if (state is FavoriteLoaded) {
                        return IconButton(
                          onPressed: () {
                            final token = userProvider.currentUser?.token;
                            if (token != null) {
                              context.read<FavoriteCubit>().toggleFavorite(
                                state.isFavorite,
                                widget.movie,
                                token,
                              );
                            }
                          },
                          icon: state.isFavorite
                              ? Image.asset(AppAssets.favoriteIcon,
                              key: const ValueKey("fav"))
                              : const Icon(Icons.bookmark_outline,
                              color: Colors.white),
                        );
                      } else if (state is FavoriteError) {
                        return const Icon(
                            Icons.error_outline, color: Colors.redAccent);
                      }

                      // default state
                      return const Icon(
                          Icons.bookmark_outline, color: Colors.white);
                    },
                  ),
                ],
              ),
              const Spacer(),
              if (!(hasTrailer && videoId != null))
                const Icon(Icons.play_circle, color: Colors.white, size: 64),
              const Spacer(),
              Text(
                widget.movie.title ?? '',
                style: const TextStyle(color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.movie.year?.toString() ?? '',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
