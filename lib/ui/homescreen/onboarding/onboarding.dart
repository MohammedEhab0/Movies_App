import 'package:flutter/material.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../Widgets/CustomElevatedButton.dart';
import '../../auth/register/Register.dart';

class OnBoarding extends StatefulWidget {
  static const String routeName = "onBoarding";

  @override
  State<OnBoarding> createState() => _OnBoardingSimpleState();
}

class _OnBoardingSimpleState extends State<OnBoarding> {
  PageController controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': AppAssets.onboarding1,
      'title': 'Find Your Next\n Favorite Movie Here',
      'subtitle':
      'Get access to a huge library of movies to suit all tastes. You will surely like it.',
    },
    {
      'image': AppAssets.onboarding2,
      'title': 'Discover Movies',
      'subtitle':
      'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    },
    {
      'image': AppAssets.onboarding3,
      'title': 'Explore All Genres',
      'subtitle':
      'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    },
    {
      'image': AppAssets.onboarding4,
      'title': 'Create Watchlists',
      'subtitle':
      'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    },
    {
      'image': AppAssets.onboarding5,
      'title': 'Rate, Review, and Learn',
      'subtitle':
      'Share your thoughts on the movies you have watched. Dive deep into film details and help others discover great movies with your reviews.',
    },
    {
      'image': AppAssets.onboarding6,
      'title': 'Start Watching Now',
      // 'subtitle': 'No subtitle for this page, or add one if needed'
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      controller.nextPage(
          duration: const Duration(milliseconds: 300), // Added const
          curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, Register.routeName);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      controller.previousPage(
          duration: const Duration(milliseconds: 300), // Added const
          curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          var page = pages[index];
          var isFirst = index == 0;
          var isLast = index == pages.length - 1;

          return Stack(
            fit: StackFit.expand,
            children: [
              // Your Image.asset should be here, occupying the full space
              Image.asset(
                page['image'] ?? '',
                fit: BoxFit.cover,
                // Add a colorFilter to make the image darker if needed,
                // or just rely on the semi-transparent container below.
                // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
              ),

              // This Container needs to be semi-transparent or serve a different purpose.
              // If AppColors.blackColor is Colors.black (opaque), it will cover the image.
              // Change it to use an opacity value:
              Container(
                // Option 1: Use Colors.black with opacity
                color: Colors.black.withOpacity(0.6), // Adjust opacity as desired (e.g., 0.5 for 50% opacity)
                // Option 2: Ensure AppColors.blackColor itself has an alpha value in its definition
                // color: AppColors.blackColor.withOpacity(0.6), // if AppColors.blackColor is already Color(0xFF000000)
              ),

              // The rest of your UI elements will be on top of the image and the overlay
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.05),
                    const Spacer(flex: 3), // Added const
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06,
                        vertical: height * 0.035,
                      ),
                      decoration: const BoxDecoration( // Added const for BoxDecoration
                        color: AppColors.blackColor, // This bottom container is opaque black
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              page['title'] ?? '',
                              style: isFirst
                                  ? AppStyles.medium36white
                                  : AppStyles.bold24White,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: height * 0.015),
                          if (page['subtitle'] != null)
                            Text(
                              page['subtitle'] ?? '',
                              style: AppStyles.regular20white,
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),
                          SizedBox(height: height * 0.03),

                          CustomElevatedButton(
                            onPressed: nextPage,
                            textButton: isFirst
                                ? "Explore Now"
                                : isLast
                                ? "Finish"
                                : "Next",
                            bgColor: AppColors.yellowColor,
                            textColor: AppColors.blackColor,
                            textStyle: AppStyles.semiBold20Black,
                          ),
                          if (index >= 2 || isLast)
                            SizedBox(height: height * 0.015),

                          if (index >= 2 || isLast)
                            CustomElevatedButton(
                              onPressed: previousPage,
                              textButton: "Back",
                              bgColor: AppColors.transparentColor,
                              textColor: AppColors.yellowColor,
                              textStyle: AppStyles.semiBold20yellow,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}