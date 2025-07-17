// File: search_tab_wrapper.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/ui/homescreen/tabs/home/Cubit/movie_view_model.dart';
import 'package:movie_app/ui/homescreen/tabs/search/Cubit/SearchViewModel.dart';
import 'package:movie_app/ui/homescreen/tabs/search/search_tab.dart';

import '../../../Di/di.dart';

class SearchTabWrapper extends StatelessWidget {
  const SearchTabWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchViewModel>(
          create: (_) => getIt<SearchViewModel>(),
        ),
        BlocProvider<MoviesCubit>(
          create: (_) => getIt<MoviesCubit>(),
        ),
      ],
      child: SearchTab(),
    );
  }
}
