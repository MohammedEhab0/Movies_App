import 'package:cached_network_image/cached_network_image.dart';
import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster(
    this.image, {
    super.key,
    this.width = 100,
    this.height = 100,
    this.bgColor,
    this.borderWidth = 0,
    this.borderColor,
    this.trBackground = false,
    this.fit = BoxFit.cover,
    this.isNetwork = true,
    this.radius = 50,
    this.isShadow = true,
  });

  final String image;
  final double width;
  final double height;
  final double borderWidth;
  final bool isShadow;
  final Color? borderColor;
  final Color? bgColor;
  final bool trBackground;
  final bool isNetwork;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          if (isShadow)
            const BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
        ],
      ),
      child: isNetwork
          ? CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  image: DecorationImage(image: imageProvider, fit: fit),
                ),
              ),
            )
          : Image(image: AssetImage(image), fit: fit),
    );
  }
}

class MoviePosterCard extends StatelessWidget {
  final Movies movie;
  final double? width, height;
  final VoidCallback? onPressed;

  const MoviePosterCard({
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            MoviePoster(
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.whiteBgColor,
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
