import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayMovieWidget extends StatelessWidget {
  final Movies movie;

  const PlayMovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final hasTrailer =
        movie.ytTrailerCode != null && movie.ytTrailerCode!.isNotEmpty;
    final videoUrl = "https://www.youtube.com/watch?v=${movie.ytTrailerCode}";
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

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
            movie.largeCoverImage ?? '',
            height: height * 0.5,
            width: width,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: height * 0.5,
              width: width,
              color: Colors.grey,
              child: const Center(
                child: Text(
                  "Video not found",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        Container(
          height: height * 0.5,
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.03,
          ),
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
                  BackButton(color: Colors.white),
                  Icon(Icons.bookmark_outline, color: Colors.white),
                ],
              ),
              const Spacer(),
              if (!(hasTrailer &&
                  videoId != null)) // only show icon if no trailer
                const Icon(Icons.play_circle, color: Colors.white, size: 64),
              const Spacer(),
              Text(
                movie.title ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                movie.year?.toString() ?? '',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
