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
    var width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: slider[index].mediumCoverImage ?? '',
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) {
              print('Error loading image: $error');
              return Container(
                color: Colors.black12,
                width: double.infinity,
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image,
                        size: 40, color: AppColors.whiteColor),
                    SizedBox(height: 8),
                    Text('Image not available'),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                color: AppColors.blackColor,
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
                // color: AppColors.yellowColor,
                width: 15,
                height: 15,
              ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
