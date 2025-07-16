import 'package:copy_movie/utils/app_colors.dart';
import 'package:copy_movie/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CastContainer extends StatelessWidget {
  final String name;
  final String character;
  final String? imageUrl;

  const CastContainer({
    super.key,
    required this.name,
    required this.character,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.12,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.08,
            backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                ? NetworkImage(imageUrl!)
                : null,
            child: (imageUrl == null || imageUrl!.isEmpty)
                ? Icon(Icons.person, size: screenWidth * 0.08)
                : null,
          ),
          SizedBox(width: screenWidth * 0.04),
          // FIX: Wrap the Column with an Expanded widget
          Expanded(
            // This Expanded widget will make the Column take up remaining space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name: $name",
                  style: AppStyles.regular14White,
                  maxLines: 1,
                  // Added maxLines to prevent overflow within the Column
                  overflow: TextOverflow
                      .ellipsis, // Ensure ellipsis works if name is too long
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Character: $character",
                  style: AppStyles.regular14White,
                  maxLines: 1,
                  // Added maxLines to prevent overflow within the Column
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}