import 'package:copy_movie/ui/homescreen/tabs/explore/browse_tab.dart';
import 'package:copy_movie/ui/homescreen/tabs/home/home_tab.dart';
import 'package:copy_movie/ui/homescreen/tabs/profile/profile_tab.dart';
import 'package:copy_movie/ui/homescreen/tabs/search/SearchTabWrapper.dart';
import 'package:copy_movie/ui/homescreen/tabs/search/search_tab.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabsList = [
    HomeTab(),
    ExploreTab(),
    SearchTabWrapper(),
     ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabsList[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.only(top: 8),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          showSelectedLabels: false,
          selectedItemColor: AppColors.yellowColor,
          unselectedItemColor: AppColors.whiteColor,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: buildNavIcon(
                selected: selectedIndex == 0,
                icon: AppAssets.homeIcon,
                selectedIcon: AppAssets.selectedHomeIcon,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: buildNavIcon(
                selected: selectedIndex == 1,
                icon: AppAssets.explore,
                selectedIcon: AppAssets.selectedExploreIcon,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: buildNavIcon(
                selected: selectedIndex == 2,
                icon: AppAssets.search,
                selectedIcon: AppAssets.selectedSearchIcon,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: buildNavIcon(
                selected: selectedIndex == 3,
                icon: AppAssets.Profiel,
                selectedIcon: AppAssets.selectedProfielIcon,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavIcon({
    required bool selected,
    required String icon,
    required String selectedIcon,
  }) {
    return Image.asset(
      selected ? selectedIcon : icon,
      // width: 24,
      // height: 24,
      color: selected ? AppColors.yellowColor : AppColors.whiteColor,
    );
  }
}
