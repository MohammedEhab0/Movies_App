import 'package:carousel_slider/carousel_options.dart';
import 'package:copy_movie/ui/Widgets/movie_card.dart';
import 'package:copy_movie/ui/Widgets/movie_slider.dart';
import 'package:copy_movie/ui/homescreen/tabs/home/Cubit/movie_states.dart';
import 'package:copy_movie/ui/homescreen/tabs/home/Cubit/movie_view_model.dart';
import 'package:copy_movie/ui/movie%20details/movie_details_screen.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:copy_movie/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomePageState();
}

class _HomePageState extends State<HomeTab> {
  final MoviesCubit viewModel = MoviesCubit();
  int newIndex = 0;

  @override
  void initState() {
    super.initState();
    viewModel.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MoviesError) {
            return Center(
              child: Text(state.message, style: AppStyles.regular15yellow),
            );
          } else if (state is MoviesSucess) {
            final movies = state.movies;
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(movies[newIndex].largeCoverImage ?? ''),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {},
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: height * 0.04),
                      Center(
                        child: Image.asset(
                          AppAssets.AvailableNow,
                          width: width * 0.6,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      MovieSlider(
                        height: height,
                        slider: movies,
                        onItemTap: (index) async {
                          final movie = movies[index];
                          final movieDetails = await viewModel
                              .fetchMovieDetails(movie.id ?? 0);
                          if (movieDetails != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                  movie: movieDetails,
                                  similarMovies: movies,
                                ),
                              ),
                            );
                          }
                          setState(() {
                            newIndex = index;
                          });
                        },
                        onPageChanged:
                            (
                              int index,
                              CarouselPageChangedReason
                              carouselPageChangedReason,
                            ) {
                              setState(() {
                                newIndex = index;
                              });
                            },
                      ),
                      SizedBox(height: height * 0.03),
                      Center(
                        child: Image.asset(
                          AppAssets.WatchNow,
                          width: width * 0.6,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          // Text(
                          //   '${movies[newIndex].genres ?? ''}',
                          //   style: AppStyles.regular20White,
                          // ),
                          const Spacer(),
                          Text("See more", style: AppStyles.regular16yellow),
                          Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: AppColors.yellowColor,
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.015),
                      SizedBox(
                        height: height * 0.35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return Padding(
                              padding: EdgeInsets.only(right: width * 0.03),
                              child: MovieCard(
                                width: width * 0.38,
                                height: height * 0.33,
                                movie: movie,
                                onPressed: () async {
                                  final movieDetails = await viewModel
                                      .fetchMovieDetails(movie.id ?? 0);
                                  if (movieDetails != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsScreen(
                                              movie: movieDetails,
                                              similarMovies: movies,
                                            ),
                                      ),
                                    );
                                  }
                                  if (movie.genres != movies[newIndex].genres) {
                                    setState(() {
                                      newIndex = index;
                                    });
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }

  void changeGrenIndex(int index) {
    setState(() {
      newIndex = index;
    });
  }
}
