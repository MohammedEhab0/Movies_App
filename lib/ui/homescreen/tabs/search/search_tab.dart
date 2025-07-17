// File: search_tab.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/ui/Widgets/movie_card.dart';
import 'package:movie_app/ui/homescreen/tabs/search/Cubit/SearchStates.dart';
import 'package:movie_app/ui/homescreen/tabs/search/Cubit/SearchViewModel.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

import '../../../Widgets/CustomTextField.dart';
import '../../../movie details/movie_details_screen.dart';
import '../home/Cubit/movie_view_model.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late SearchViewModel searchViewModel;
  late MoviesCubit movieViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    searchViewModel = context.read<SearchViewModel>();
    movieViewModel = context.read<MoviesCubit>();
    searchViewModel.searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchViewModel.searchController.text.trim();
    searchViewModel.Search(query);
  }

  @override
  void dispose() {
    searchViewModel.searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: searchViewModel.searchController,
                prefixIcon: Image.asset(AppAssets.search),
                hintText: 'search'.tr(),
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: BlocBuilder<SearchViewModel, SearchState>(
                  builder: (context, state) {
                    final isEmptySearch =
                        searchViewModel.searchController.text.trim().isEmpty;

                    if (isEmptySearch) return _buildEmptyState();
                    if (state is SearchLoadingState) return _buildLoadingIndicator();
                    if (state is SearchErrorState) return _buildEmptyState();
                    if (state is SearchSuccessState) {
                      if (state.movies.isEmpty) return _buildEmptyState();
                      return _buildMovieGrid(state);
                    }
                    return _buildInitialMessage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(child: Image.asset(AppAssets.profileEmpty));
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.yellowColor),
    );
  }

  Widget _buildInitialMessage() {
    return Center(
      child: Text(
        'Start typing to search for movies...',
        style: AppStyles.regular20White,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMovieGrid(SearchSuccessState state) {
    return GridView.builder(
      itemCount: state.movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 198 / 279,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: MovieCard(
            movie: state.movies[index],
            onPressed: () async {
              final movieDetails = await movieViewModel
                  .fetchMovieDetails(state.movies[index].id ?? 0);
              if (movieDetails != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsScreen(
                      movie: movieDetails,
                      similarMovies: state.movies,
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
