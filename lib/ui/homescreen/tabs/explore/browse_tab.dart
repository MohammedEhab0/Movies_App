import 'package:copy_movie/UI/Di/di.dart';
import 'package:copy_movie/ui/Widgets/browse_tabs.dart';
import 'package:copy_movie/ui/Widgets/movie_browse_item.dart';
import 'package:copy_movie/ui/homescreen/tabs/explore/Cubit/browse_states.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/browse_view_model.dart';

class ExploreTab extends StatefulWidget {
  ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  BrowseViewModel viewModel = getIt<BrowseViewModel>(); // field injection

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 15,
            children: [
              DefaultTabController(
                length: viewModel.genres.length,
                child: TabBar(
                  indicatorColor: AppColors.transparentColor,
                  dividerColor: AppColors.transparentColor,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.only(right: 8),
                  onTap: (index) {
                    viewModel.selectedIndex = index;
                    setState(() {});
                    // viewModel.getMovies(genres[index]);
                  },
                  tabs: viewModel.genres.map((genre) {
                    return BrowseTabs(
                      title: genre,
                      isSelected: viewModel.selectedIndex == viewModel.genres.indexOf(genre),
                    );
                  }).toList(),
                ),
              ),
              BlocBuilder<BrowseViewModel, BrowseStates>(
                bloc: viewModel..getMovies(viewModel.genres[viewModel.selectedIndex]),
                builder: (context, state) {
                  if (state is BrowseSuccessState) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10,
                            ),
                        itemCount: state.movieList!.length,
                        itemBuilder: (context, index) {
                          return MovieBrowseItem(
                            movies: state.movieList![index],
                          );
                        },
                      ),
                    );
                  } else if (state is BrowseErrorState) {
                    return Center(
                      child: Text(
                        "${state.errorMessage}",
                        style: const TextStyle(color: AppColors.yellowColor),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.yellowColor,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
