import 'package:cached_network_image/cached_network_image.dart';
import 'package:copy_movie/Data/models/MovieRespone.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../utils/app_assets.dart';

class ItemBuilder extends StatelessWidget {
  ItemBuilder({
    super.key,
    required this.slider,
    required this.index,
    this.ratting = '',
  });

  final List<Movies> slider;
  final int index;
  String ratting;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final imageHeight = screenHeight * 0.45; // Customize as needed

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: screenWidth,
        height: imageHeight,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: slider[index].mediumCoverImage ?? '',
              width: screenWidth,
              height: imageHeight,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) {
                print('Error loading image: $error');
                return Container(
                  color: Colors.transparent,
                  width: screenWidth,
                  height: imageHeight,
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image,
                          size: 40, color: AppColors.whiteColor),
                      SizedBox(height: 8),
                      Text('Image not available',
                          style: TextStyle(color: AppColors.whiteColor)),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  vertical: screenHeight * 0.005,
                ),
                decoration: BoxDecoration(
                  color: AppColors.blackColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      '${slider[index].rating ?? ''}',
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      AppAssets.starIcon,
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
