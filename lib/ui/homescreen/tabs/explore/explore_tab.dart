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
  BrowseViewModel viewModel = BrowseViewModel();

  int selectedIndex = 0;

  final List<String> genres = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "Horror",
    "Music",
    "Musical",
    "Romance",
    "Sci‑Fi",
    "Thriller",
    "Western",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DefaultTabController(
                  length: genres.length,
                  child: TabBar(
                    indicatorColor: AppColors.transparentColor,
                    dividerColor: AppColors.transparentColor,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    onTap: (index) {
                      selectedIndex = index;
                      setState(() {});
                      // viewModel.getMovies(genres[index]);
                    },
                    tabs: genres.map((genre) {
                      return BrowseTabs(
                          title: genre,
                          isSelected: selectedIndex == genres.indexOf(genre)
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<BrowseViewModel,BrowseStates>(
                    bloc: viewModel..getMovies(genres[selectedIndex]),
                    builder: (context,state){
                      if(state is BrowseSuccessState){
                        return Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 15
                            ),
                            itemCount: state.movieList!.length,
                            itemBuilder: (context,index){
                              return MovieBrowseItem(
                                movies: state.movieList![index],
                              );
                            },
                          ),
                        );
                      }else if(state is BrowseErrorState){
                        return Center(
                          child: Text(
                              "${state.errorMessage}",
                              style: const TextStyle(
                                  color: AppColors.yellowColor
                              )
                          ),
                        );
                      }
                      else{
                        return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.yellowColor,
                            )
                        );
                      }
                    }
                ),
              ],
            ),
          )
      ),
    );
  }
}
