import 'package:flutter/material.dart';
import 'package:movie_app/Data/models/MovieRespone.dart';
import 'package:movie_app/ui/Widgets/movie_poster.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';

class MovieCard extends StatelessWidget {
  final Movies movie;
  final double? width, height;
  final VoidCallback? onPressed;

  const MovieCard({
    super.key,
    required this.movie,
    this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = width ?? screenWidth * 0.45;
    final cardHeight = height ?? screenHeight * 0.3;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            CustomImage(
              movie.mediumCoverImage ?? '',
              width: cardWidth,
              height: cardHeight,
              isNetwork: true,
              fit: BoxFit.cover,
              radius: 12,
              isShadow: false,
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.whiteBgColor.withAlpha(181),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Text(
                      movie.rating?.toString() ?? '',
                      style: const TextStyle(
                        color: AppColors.yellowColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(AppAssets.starIcon,scale: 2,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
