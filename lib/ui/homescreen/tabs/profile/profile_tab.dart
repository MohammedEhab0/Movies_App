import 'package:copy_movie/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:copy_movie/UI/Widgets/CustomElevatedButton.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_styles.dart';
import '../../../Di/di.dart';
import 'cubit/profile_and_favourite_states.dart';
import 'cubit/profile_and_favourite_view_model.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<ProfileViewModel>();
    viewModel.fetchProfile();
    viewModel.fetchFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var userProvider = Provider.of<UserProvider>(context);

    return BlocProvider<ProfileViewModel>(
      create: (_) => viewModel,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.blackColor,
          body: SafeArea(
            child: Column(
              children: [
                BlocBuilder<ProfileViewModel, ProfilesStates>(
                  builder: (context, state) {
                    if (state is ProfilesLoading) {
                      return SizedBox(
                        height: height * 0.4,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is ProfilesError) {
                      return SizedBox(
                        height: height * 0.4,
                        child: Center(
                          child: Text(
                            state.message,
                            style: AppStyles.regular20White,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else if (state is ProfilesSuccess) {
                      final profile = state.profile;
                      final avatarIndex = profile.data?.avaterId ?? 0;
                      final avatarPath = (avatarIndex >= 0 && avatarIndex < viewModel.avatarList.length)
                          ? viewModel.avatarList[avatarIndex]
                          : AppAssets.character1;

                      return Container(
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
                                  backgroundImage: AssetImage(avatarPath),
                                ),
                                SizedBox(width: width * 0.03),
                                Expanded(
                                  child: Text(
                                    profile.data?.name ?? 'no name',
                                    style: AppStyles.bold20White.copyWith(fontSize: width * 0.05),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              userProvider.currentUser?.token ?? 'No token',
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.bold20White.copyWith(fontSize: width * 0.045),
                            ),
                            SizedBox(height: height * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CustomElevatedButton(
                                    bgColor: AppColors.yellowColor,
                                    onPressed: () {
                                      // Edit profile action
                                    },
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
                                    onPressed: () {
                                      userProvider.logout();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.005),
                            TabBar(
                              indicatorColor: AppColors.yellowColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: [
                                Tab(
                                  icon: Icon(Icons.list, color: AppColors.yellowColor, size: width * 0.07),
                                  child: Text(
                                    'Watch List',
                                    style: AppStyles.regular20White.copyWith(fontSize: width * 0.04),
                                  ),
                                ),
                                Tab(
                                  icon: Icon(Icons.folder, color: AppColors.yellowColor, size: width * 0.07),
                                  child: Text(
                                    'History',
                                    style: AppStyles.regular20White.copyWith(fontSize: width * 0.04),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: height * 0.4,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: TabBarView(
                      children: [
                        BlocBuilder<ProfileViewModel, ProfilesStates>(
                          builder: (context, state) {
                            if (state is FavouritesLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is FavouritesError) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style: AppStyles.regular20White,
                                ),
                              );
                            } else if (state is FavouritesSuccess) {
                              final favourites = state.favourites;
                              if (favourites.isEmpty) {
                                return Center(
                                  child: Image.asset(
                                    AppAssets.profileEmpty,
                                    width: width * 0.5,
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: favourites.length,
                                  itemBuilder: (context, index) {
                                    final item = favourites[index];
                                    return ListTile(
                                      leading: Image.network(
                                        item.posterPath,
                                        width: 50,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(
                                        item.title,
                                        style: AppStyles.bold20White.copyWith(fontSize: width * 0.04),
                                      ),
                                    );
                                  },
                                );
                              }
                            } else {
                              return Center(child: Text("Something went wrong", style: AppStyles.regular20White));
                            }
                          },
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
