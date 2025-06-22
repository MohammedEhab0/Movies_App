import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:flutter/material.dart';

class WatchBtnAndScreenShots extends StatelessWidget {
  final Movies movie;

  const WatchBtnAndScreenShots({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final screenshots = [
      movie.mediumScreenshotImage1,
      movie.mediumScreenshotImage2,
      movie.mediumScreenshotImage3,
    ].whereType<String>().toList();

    print("Screenshot 1: ${movie.mediumScreenshotImage1}");
    print("Screenshot 2: ${movie.mediumScreenshotImage2}");
    print("Screenshot 3: ${movie.mediumScreenshotImage3}");

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              if (movie.ytTrailerCode != null &&
                  movie.ytTrailerCode!.isNotEmpty) {
                final url =
                    'https://www.youtube.com/watch?v=${movie.ytTrailerCode}';
                print('Open: $url');
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              backgroundColor: Colors.redAccent,
            ),
            child: const Text("Watch", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              detailItem(
                AppAssets.heartIcon,
                movie.likeCount?.toString() ?? "0",
              ),
              detailItem(AppAssets.clockIcon, "${movie.runtime ?? 90} min"),
              detailItem(AppAssets.starIcon, movie.rating?.toString() ?? "9.8"),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Screen Shots",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          screenshots.isNotEmpty
              ? SizedBox(
                  height: height * 0.25,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: screenshots.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        screenshots[index],
                        width: width * 0.6,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: width * 0.6,
                            color: Colors.grey[900],
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.redAccent,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) => Container(
                          width: width * 0.6,
                          color: Colors.grey,
                          child: const Center(
                            child: Text(
                              "Image not found",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const Text(
                  "No screenshots available",
                  style: TextStyle(color: Colors.white),
                ),
          const SizedBox(height: 16),
          const Text(
            "Similar",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget detailItem(String imagePath, String value) {
    return Row(
      children: [
        Image.asset(imagePath, width: 20, height: 20, fit: BoxFit.contain),
        const SizedBox(width: 6),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
