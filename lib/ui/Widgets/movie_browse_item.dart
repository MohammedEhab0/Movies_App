import 'package:cached_network_image/cached_network_image.dart';
import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MovieBrowseItem extends StatelessWidget {
  Movies movies;
  MovieBrowseItem({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: movies.mediumCoverImage ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(child: CircularProgressIndicator(color: AppColors.yellowColor,)),
            errorWidget: (context, url, error) => Icon(Icons.error , color: AppColors.yellowColor,),
          ),
        ),
        Positioned(
          top: 10,
          left: 6,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.transparentColor.withAlpha(150),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(movies.rating.toString(),
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold)),
                Icon(Icons.star, color: AppColors.yellowColor, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
