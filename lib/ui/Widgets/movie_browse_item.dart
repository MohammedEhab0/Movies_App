import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Data/models/MovieRespone.dart';
import 'package:movie_app/utils/app_colors.dart';

class MovieBrowseItem extends StatelessWidget {
  final Movies movies;
  final VoidCallback? onTap;

  const MovieBrowseItem({super.key, required this.movies, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: movies.mediumCoverImage ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(
                    child: CircularProgressIndicator(
                        color: AppColors.yellowColor),
                  ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: AppColors.yellowColor),
            ),
          ),
          Positioned(
            top: 10,
            left: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.transparentColor.withAlpha(150),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    movies.rating?.toString() ?? '',
                    style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.star,
                      color: AppColors.yellowColor, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

