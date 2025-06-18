import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:copy_movie/ui/Widgets/movie_card.dart';
import 'package:copy_movie/ui/homescreen/tabs/search/Cubit/SearchStates.dart';
import 'package:copy_movie/ui/homescreen/tabs/search/Cubit/SearchViewModel.dart';
import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:copy_movie/utils/app_styles.dart';

import '../../../Di/di.dart';
import '../../../Widgets/CustomTextField.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late final SearchViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<SearchViewModel>();
    viewModel.searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = viewModel.searchController.text.trim();
    viewModel.Search(query);
  }

  @override
  void dispose() {
    viewModel.close();
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
                controller: viewModel.searchController,
                prefixIcon: Image.asset(AppAssets.search),
                hintText: 'search'.tr(),
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: BlocBuilder<SearchViewModel, SearchState>(
                  bloc: viewModel,
                  builder: (context, state) {
                    final isEmptySearch = viewModel.searchController.text.trim().isEmpty;

                    if (isEmptySearch) {
                      return _buildEmptyState(); // only show image when search bar is empty
                    }

                    if (state is SearchLoadingState) {
                      return _buildLoadingIndicator();
                    } else if (state is SearchErrorState) {
                      return _buildEmptyState();
                    } else if (state is SearchSuccessState) {
                      if (state.movies.isEmpty) {
                        return _buildEmptyState();
                      }
                      return _buildMovieGrid(state);
                    } else {
                      return _buildInitialMessage();
                    }
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
    return Center(
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
          child: MovieCard(movie: state.movies[index]),
        );
      },
    );
  }
}
