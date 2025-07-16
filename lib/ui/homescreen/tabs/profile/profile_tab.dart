import 'package:copy_movie/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// IMPORTANT: Now you only need to import the redefined FavouriteModelItem
import '../../../../Data/models/FavouriteModelItem.dart'; // This now defines FavouriteItemModel directly
import '../../../../Data/models/MovieRespone.dart'
    hide Data; // Keep hide Data if MovieResponse also has a 'Data' class
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/app_styles.dart';
import '../../../Di/di.dart';
import '../../../Widgets/CustomElevatedButton.dart';
import '../../../Widgets/movie_card.dart';
import '../../../auth/login/Login.dart';
import '../../../movie details/movie_details_screen.dart';
import 'cubit/profile_and_favourite_states.dart';
import 'cubit/profile_and_favourite_view_model.dart';

class ProfileTab extends StatefulWidget {
  static String routeName = 'ProfileTab';

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  ProfileViewModel viewModel = getIt<ProfileViewModel>();
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    _fetchProfileAndFavouritesData();
  }

  void _fetchProfileAndFavouritesData() {
    final token = userProvider.currentUser?.token;
    if (token != null) {
      viewModel.fetchProfileAndFavourites(token);
    } else {
      print("User token is null in ProfileTab initState.");
    }
  }

  // --- SIMPLIFIED METHOD ---
  // The 'fav' parameter is now directly FavouriteItemModel
  Movies mapFavouriteToMovie(FavouriteItemModel fav) {
    // Change type to FavouriteItemModel
    return Movies(
      year: int.tryParse(fav.year!) ?? 0,
      rating: fav.rating,
      // Use fav.movieId directly
      id: int.tryParse(fav.movieId ?? '') ?? 0,
      title: fav.name ?? 'Unknown',
      mediumCoverImage: fav.imageURL ?? '',
    );
  }

  // --- END SIMPLIFIED METHOD ---

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: viewModel,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.blackColor,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: height * 0.35,
                  floating: true,
                  pinned: true,
                  snap: true,
                  backgroundColor: AppColors.blackColor,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _ProfileHeader(
                      viewModel: viewModel,
                      userProvider: userProvider,
                      width: width,
                      height: height,
                      onEditProfile: () {
                        Navigator.of(context).pushNamed(AppRoutes
                            .updateProfileRoute);
                      },
                      onExit: () {
                        userProvider.logout();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Login.routeName,
                              (route) => false,
                        );
                      },
                    ),
                  ),
                  bottom: const TabBar(
                    indicatorColor: AppColors.yellowColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      _ProfileTabIndicator(
                        icon: Icons.list,
                        label: 'Watch List',
                      ),
                      _ProfileTabIndicator(
                        icon: Icons.folder,
                        label: 'History',
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                BlocBuilder<ProfileViewModel, ProfilesStates>(
                  builder: (context, state) {
                    if (state is ProfileAndFavouritesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProfileAndFavouritesError) {
                      return Center(
                        child: Text(state.message, style: AppStyles
                            .regular20White),
                      );
                    } else if (state is ProfileAndFavouritesSuccess) {
                      if (state.favouriteErrorMessage != null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline,
                                  color: AppColors.redColor, size: width * 0.1),
                              SizedBox(height: 8),
                              Text(state.favouriteErrorMessage!,
                                  style: AppStyles.regular20White,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () =>
                                    _fetchProfileAndFavouritesData(),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.yellowColor),
                                child: Text(
                                    'Retry', style: AppStyles.regular16black),
                              ),
                            ],
                          ),
                        );
                      }
                      // Now, 'favourites' is already List<FavouriteItemModel>
                      final favourites = state.favourites;
                      if (favourites == null || favourites.isEmpty) {
                        return Center(
                          child: Image.asset(
                            AppAssets.profileEmpty,
                            width: width * 0.5,
                          ),
                        );
                      } else {
                        // The mapping is now direct and type-safe
                        final mappedMovies = favourites.map(mapFavouriteToMovie)
                            .toList();
                        return GridView.builder(
                          itemCount: mappedMovies.length,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 4),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                            childAspectRatio: 198 / 279,
                          ),
                          itemBuilder: (context, index) {
                            final movie = mappedMovies[index];
                            return MovieCard(
                              movie: movie,
                              onPressed: () async {
                                try {
                                  final movieDetails = await viewModel
                                      .fetchMovieDetails(movie.id ?? 0);
                                  if (movieDetails != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsScreen(
                                              movie: movieDetails,
                                              similarMovies: mappedMovies,
                                            ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Failed to load movie details.'),
                                        backgroundColor: AppColors.redColor,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Error loading movie details: $e'),
                                      backgroundColor: AppColors.redColor,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                Center(
                  child: Icon(Icons.history,
                      size: width * 0.25, color: AppColors.yellowColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.viewModel,
    required this.userProvider,
    required this.width,
    required this.height,
    required this.onEditProfile,
    required this.onExit,
  });

  final ProfileViewModel viewModel;
  final UserProvider userProvider;
  final double width;
  final double height;
  final VoidCallback onEditProfile;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfilesStates>(
      builder: (context, state) {
        if (state is ProfileAndFavouritesLoading) {
          return Container(
            color: AppColors.lightBlack,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProfileAndFavouritesError) {
          return Container(
            color: AppColors.lightBlack,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: AppColors.redColor,
                      size: width * 0.1),
                  SizedBox(height: 8),
                  Text(state.message, style: AppStyles.regular20White,
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        } else if (state is ProfileAndFavouritesSuccess) {
          if (state.profileErrorMessage != null) {
            return Container(
              color: AppColors.lightBlack,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: AppColors.redColor,
                        size: width * 0.1),
                    SizedBox(height: 8),
                    Text(state.profileErrorMessage!,
                        style: AppStyles.regular20White,
                        textAlign: TextAlign.center),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }
          final profile = state.profile;
          // Get the count of favorite movies
          final favouriteCount = state.favourites?.length ?? 0;

          if (profile == null || profile.data == null) {
            return Container(
              color: AppColors.lightBlack,
              child: Center(
                child: Text(
                  "No profile data available.",
                  style: AppStyles.regular20White,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final avatarIndex = profile.data?.avaterId ?? 0;
          final avatarPath = viewModel.getAvatarById(avatarIndex);

          return Container(
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
                        style: AppStyles.bold20White
                            .copyWith(fontSize: width * 0.05),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                // --- REPLACED CODE STARTS HERE ---
                Row(
                  children: [
                    Text(
                      'Watch List',
                      style: AppStyles.bold20White
                          .copyWith(fontSize: width * 0.045),
                    ),
                    SizedBox(width: width * 0.04), // Add some spacing
                    Text(
                        '$favouriteCount', // Display the count
                        style: AppStyles.semiBold20yellow
                    ),
                  ],
                ),
                // --- REPLACED CODE ENDS HERE ---
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomElevatedButton(
                        bgColor: AppColors.yellowColor,
                        onPressed: onEditProfile,
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
                        textStyle: AppStyles.regular20White
                            .copyWith(fontSize: width * 0.045),
                        onPressed: onExit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ProfileTabIndicator extends StatelessWidget {
  const _ProfileTabIndicator({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Tab(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.yellowColor, size: width * 0.07),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppStyles.regular20White.copyWith(fontSize: width * 0.04),
            ),
          ],
        ),
      ),
    );
  }
}