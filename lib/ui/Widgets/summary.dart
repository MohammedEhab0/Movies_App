import 'package:flutter/material.dart';
import 'package:movie_app/Data/models/MovieRespone.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

import 'cast_container.dart';

class SummaryAndCast extends StatelessWidget {
  final Movies movie;

  const SummaryAndCast({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    print("Movie Summary: ${movie.descriptionFull}");

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Summary",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            movie.descriptionFull ?? 'No summary available.',
            style: AppStyles.medium20White,
          ),
          const SizedBox(height: 16),
          const Text(
            "Cast",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Column(
            children:
                movie.cast?.map((c) {
                  return CastContainer(
                    name: c.name ?? '',
                    character: c.characterName ?? '',
                    imageUrl: c.image,
                  );
                }).toList() ??
                [
                  const Text(
                    "No cast available",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Genres",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                movie.genres?.map((genre) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(genre, style: AppStyles.regular14white),
                  );
                }).toList() ??
                [
                  const Text(
                    "No genres available",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
