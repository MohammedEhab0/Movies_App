import 'package:copy_movie/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:copy_movie/UI/Widgets/CustomElevatedButton.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_styles.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var userProvider = Provider.of<UserProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: SafeArea(
          child: Expanded(
            child: Column(
              children: [
                Container(
                  height: height * 0.4,
                  color: AppColors.lightBlack,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.025,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: width * 0.12,
                            backgroundColor: AppColors.whiteColor,
                            backgroundImage: AssetImage(AppAssets.character8),
                          ),
                          SizedBox(width: width * 0.03),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text('12', style: AppStyles.bold36White.copyWith(fontSize: width * 0.08)),
                                    SizedBox(height: height * 0.005),
                                    Text('Wish List', style: AppStyles.bold24White.copyWith(fontSize: width * 0.045)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('10', style: AppStyles.bold36White.copyWith(fontSize: width * 0.08)),
                                    SizedBox(height: height * 0.005),
                                    Text('History', style: AppStyles.bold24White.copyWith(fontSize: width * 0.045)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      Text(overflow: TextOverflow.ellipsis,userProvider.currentUser!.token, style: AppStyles.bold20White.copyWith(fontSize: width * 0.05)),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomElevatedButton(
                              bgColor: AppColors.yellowColor,
                              onPressed: () {},
                              textButton: 'Edit profile',
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Expanded(
                            flex: 1,
                            child: CustomElevatedButton(
                              textButton: 'Exit',
                              bgColor: AppColors.redColor,
                              icon: Icons.logout,
                              textColor: Colors.white,
                              textStyle: AppStyles.regular20White.copyWith(fontSize: width * 0.045),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.005),
                      Expanded(
                        child: Container(
                          child: TabBar(
                            indicatorColor: AppColors.yellowColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [
                              Tab(
                                icon: Icon(Icons.list, color: AppColors.yellowColor, size: width * 0.07),
                                child: Text('Watch List', style: AppStyles.regular20White.copyWith(fontSize: width * 0.04)),
                              ),
                              Tab(
                                icon: Icon(Icons.folder, color: AppColors.yellowColor, size: width * 0.07),
                                child: Text('History', style: AppStyles.regular20White.copyWith(fontSize: width * 0.04)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom tab content
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: TabBarView(
                      children: [
                        Center(
                          child: Image.asset(
                            AppAssets.profileEmpty,
                            width: width * 0.5,
                          ),
                        ),
                        Center(
                          child: Icon(Icons.history, size: width * 0.25, color: AppColors.yellowColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
