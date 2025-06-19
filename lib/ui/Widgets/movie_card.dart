import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/ui/Widgets/movie_poster.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? 198,
        height: height ?? 279,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            CustomImage(
              movie.mediumCoverImage ?? '',
              width: width ?? 198,
              height: height ?? 279,
              isNetwork: true,
              fit: BoxFit.cover,
              radius: 12,
              isShadow: false,
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.whiteBgColor.withAlpha(181),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Text(
                      movie.rating?.toString() ?? '',
                      style: TextStyle(
                        color: AppColors.yellowColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    SvgPicture.asset(
                      AppAssets.starIcon,
                      color: AppColors.yellowColor,
                      width: 15,
                      height: 15,
                    ),
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
