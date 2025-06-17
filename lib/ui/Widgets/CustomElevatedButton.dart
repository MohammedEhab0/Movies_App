import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart'; // Assuming this provides AppStyles.regular20black

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final IconData? icon;
  final String textButton;
  final Color bgColor;
  final Color? textColor;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    super.key, // Added super.key for best practice
    required this.onPressed,
    this.icon,
    required this.textButton,
    required this.bgColor,
    this.textColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // Adjusted padding to be slightly less horizontal for smaller buttons.
        // You might need to fine-tune these values.
        padding: EdgeInsets.symmetric(
            vertical: height * .02, horizontal: width * .04), // Reduced horizontal padding
        backgroundColor: bgColor,
      ),
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Keep min so button only takes space its content needs

        children: [
          // If the icon is placed after the text (as in your original code)
          // it makes sense to have the Text widget as Flexible
          Flexible( // <-- THIS IS THE CRUCIAL CHANGE
            child: Text(
              textButton,
              style: textStyle ??
                  AppStyles.regular20black.copyWith(
                    color: textColor ?? AppColors.blackColor,
                  ),
              overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
              maxLines: 1, // Ensure text stays on one line
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 6),
            Icon(icon, color: textColor ?? AppColors.blackColor),
          ],
        ],
      ),
    );
  }
}