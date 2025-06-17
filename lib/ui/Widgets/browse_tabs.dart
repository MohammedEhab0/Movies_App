import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BrowseTabs extends StatelessWidget {
  String title;
  bool isSelected;

  BrowseTabs({
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.yellowColor
            : AppColors.transparentColor,
        border: Border.all(
          color: AppColors.yellowColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? AppColors.blackColor
              : AppColors.yellowColor,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }
}
