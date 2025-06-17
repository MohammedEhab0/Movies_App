import 'package:copy_movie/Providers/SettingProvider.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ToggleLanguage extends StatefulWidget {
  const ToggleLanguage({super.key});

  @override
  _ToggleLanguageState createState() => _ToggleLanguageState();
}

class _ToggleLanguageState extends State<ToggleLanguage> {
  // We'll manage the selected language state locally
  // true for Arabic (EG), false for English (US)
  bool _isArabicSelected = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize _isArabicSelected based on the current locale from EasyLocalization
    // This makes sure the toggle reflects the current app language when it loads.
    _isArabicSelected = context.locale.languageCode == 'ar';
  }

  void _changeLanguage(BuildContext context, bool selectArabic) {
    var settingProvider = Provider.of<SettingProviders>(context, listen: false);
    // Only update state if the selection is actually changing
    if (_isArabicSelected != selectArabic) {
      setState(() {
        _isArabicSelected = selectArabic;
      });
      settingProvider.changeLanguage(context, selectArabic ? 'ar' : 'en');
    }
  }

  @override
  Widget build(BuildContext context) {
    const double flagSize = 32.0; // Size of the flag images
    const double toggleHeight = 45.0; // Overall height of the toggle
    const double borderPadding = 8.0; // Extra space around flag for border

    return Container(
      height: toggleHeight,
      // The total width will be determined by the children of the Row
      // (2 * (flagSize + borderPadding)) + internalSpacing
      decoration: BoxDecoration(
        color: AppColors.blackColor, // The dark background
        borderRadius: BorderRadius.circular(toggleHeight / 2), // Fully rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Make row only as wide as its children
        children: [
          // English (US) Flag Option
          _buildFlagOption(
            imageAsset: AppAssets.USIcon,
            isSelected: !_isArabicSelected, // True if English is selected
            flagSize: flagSize,
            borderPadding: borderPadding,
            onTap: () => _changeLanguage(context, false), // Select English
          ),
          // A small separator/gap between the flags
          const SizedBox(width: 8),

          // Arabic (EG) Flag Option
          _buildFlagOption(
            imageAsset: AppAssets.EGIcon,
            isSelected: _isArabicSelected, // True if Arabic is selected
            flagSize: flagSize,
            borderPadding: borderPadding,
            onTap: () => _changeLanguage(context, true), // Select Arabic
          ),
        ],
      ),
    );
  }

  // Helper method to build each individual flag option
  Widget _buildFlagOption({
    required String imageAsset,
    required bool isSelected,
    required double flagSize,
    required double borderPadding,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Smooth animation for border
        curve: Curves.easeInOut,
        width: flagSize + borderPadding, // Width to fit flag + border
        height: flagSize + borderPadding, // Height to fit flag + border
        alignment: Alignment.center, // Center the flag inside the container
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Make the border circular
          border: isSelected
              ? Border.all(color: AppColors.yellowColor, width: 2.0)
              : null, // No border if not selected
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent, // Ensure flag is visible
          backgroundImage: AssetImage(imageAsset),
          radius: flagSize / 2, // Half of flagSize to fit
        ),
      ),
    );
  }
}