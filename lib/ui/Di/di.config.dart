// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file


import 'package:copy_movie/Data/data_sources/profileRemoteDataSource.dart'
    as _i617;
import 'package:copy_movie/Data/data_sources/remote/FavouriteRemoteDataSource.dart'
    as _i996;

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:copy_movie/api/apiManger.dart' as _i878;
import 'package:copy_movie/Data/data_sources/remote/auth_remote_data_source.dart'
    as _i144;
import 'package:copy_movie/Data/data_sources/remote/browse%20tab/browse_tab_data_source.dart'
    as _i351;
import 'package:copy_movie/Data/data_sources/remote/browse%20tab/browse_tab_data_source_impl.dart'
    as _i572;
import 'package:copy_movie/Data/data_sources/remote/edit%20profile/edit_profile_date_source.dart'
    as _i94;
import 'package:copy_movie/Data/data_sources/remote/edit%20profile/edit_profile_date_source_impl.dart'
    as _i642;

import 'package:copy_movie/Data/data_sources/remote/HomeTabDataSource.dart'
    as _i436;
import 'package:copy_movie/Data/data_sources/remote/Impl/FavouriteRemoteDataSourceImpl.dart'
    as _i73;
import 'package:copy_movie/Data/data_sources/remote/Impl/HomeTabDataSourceImpl.dart'
    as _i580;
import 'package:copy_movie/Data/data_sources/remote/Impl/ProfileRemoteDataSourceImpl.dart'
    as _i865;
import 'package:copy_movie/Data/data_sources/remote/Impl/SearchRemoteDataSourceImpl.dart'
    as _i875;
import 'package:copy_movie/Data/data_sources/remote/Impl/auth_remote_daraSource_impl.dart'
    as _i606;
import 'package:copy_movie/Data/data_sources/remote/SearchRemoteDataSource.dart'
    as _i781;
import 'package:copy_movie/Data/data_sources/remote/auth_remote_data_source.dart'
    as _i144;
import 'package:copy_movie/Data/data_sources/remote/browse%20tab/browse_tab_data_source.dart'
    as _i351;
import 'package:copy_movie/Data/data_sources/remote/browse%20tab/browse_tab_data_source_impl.dart'
    as _i572;
import 'package:copy_movie/Data/repositories/FavouriteItems/FavouriteRepositoryImpl.dart'
    as _i952;
import 'package:copy_movie/Data/repositories/FavouriteItems/favouriteRepository.dart'
    as _i857;
import 'package:copy_movie/Data/repositories/HomeRepository.dart' as _i829;
import 'package:copy_movie/Data/repositories/HomeRepositoryImpl.dart' as _i964;
import 'package:copy_movie/Data/repositories/SearchRepository.dart' as _i390;
import 'package:copy_movie/Data/repositories/SearchRepositoryImpl.dart' as _i25;
import 'package:copy_movie/Data/repositories/auth/auth_repository.dart'
    as _i252;
import 'package:copy_movie/Data/repositories/auth/auth_repository_impl.dart'
    as _i398;
import 'package:copy_movie/Data/repositories/browse%20tab/browse_tab_repository.dart'
    as _i868;
import 'package:copy_movie/Data/repositories/browse%20tab/browse_tab_repository_impl.dart'
    as _i885;

import 'package:copy_movie/Data/repositories/getProfile/ProfileRepository.dart'
    as _i634;
import 'package:copy_movie/Data/repositories/getProfile/ProfileRepositoryImpl.dart'
    as _i897;
=======
import 'package:copy_movie/Data/repositories/edit%20profile/edit_profile_repository.dart'
    as _i686;
import 'package:copy_movie/Data/repositories/edit%20profile/edit_profile_repository_impl.dart'
    as _i85;
import 'package:copy_movie/Data/repositories/HomeRepository.dart' as _i829;
import 'package:copy_movie/Data/repositories/HomeRepositoryImpl.dart' as _i964;
import 'package:copy_movie/Data/repositories/SearchRepository.dart' as _i390;
import 'package:copy_movie/Data/repositories/SearchRepositoryImpl.dart' as _i25;

import 'package:copy_movie/Providers/UserProvider.dart' as _i427;
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:copy_movie/api/apiManger.dart' as _i878;
import 'package:copy_movie/ui/auth/login/Cubit/login_view_model.dart' as _i1061;
import 'package:copy_movie/ui/auth/register/Cubit/register_view_model.dart'
    as _i892;
import 'package:copy_movie/ui/homescreen/tabs/explore/Cubit/browse_view_model.dart'
    as _i525;
import 'package:copy_movie/ui/homescreen/tabs/home/Cubit/movie_view_model.dart'
    as _i498;

import 'package:copy_movie/ui/homescreen/tabs/profile/cubit/profile_and_favourite_view_model.dart'
    as _i414;
=======
import 'package:copy_movie/ui/homescreen/tabs/profile/edit%20profile/cubit/edit_profile_view_model.dart'
    as _i9;

import 'package:copy_movie/ui/homescreen/tabs/search/Cubit/SearchViewModel.dart'
    as _i879;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i427.UserProvider>(() => _i427.UserProvider());
    gh.factory<_i498.MoviesCubit>(() => _i498.MoviesCubit());
    gh.singleton<_i878.ApiManger>(() => _i878.ApiManger());
    gh.factory<_i617.ProfileRemoteDataSource>(
      () => _i865.ProfileRemoteDataSourceImpl(gh<_i878.ApiManger>()),
    );
    gh.factory<_i634.ProfileRepository>(
      () => _i897.ProfileRepositoryImpl(
        remoteDataSource: gh<_i617.ProfileRemoteDataSource>(),
      ),
    );
    gh.factory<_i351.BrowseTabDataSource>(
      () => _i572.BrowseTabDataSourceImpl(apiManger: gh<_i878.ApiManger>()),
    );
    gh.factory<_i436.HomeTabDataSource>(
      () => _i580.HomeTabDataSourceImpl(apiManger: gh<_i878.ApiManger>()),
    );
    gh.factory<_i996.FavouriteRemoteDataSource>(
      () =>
          _i73.FavouriteRemoteDataSourceImpl(apiManger: gh<_i878.ApiManger>()),
    );
    gh.factory<_i868.BrowseTabRepository>(
      () => _i885.BrowseTabRepositoryImpl(
        dataSource: gh<_i351.BrowseTabDataSource>(),
      ),
    );
    gh.factory<_i781.SearchRemoteDataSource>(
      () => _i875.SearchRemoteDataSourceImpl(apiManger: gh<_i878.ApiManger>()),
    );
    gh.factory<_i390.SearchRepository>(
      () => _i25.SearchRepositoryImpl(
        searchRemoteDataSource: gh<_i781.SearchRemoteDataSource>(),
      ),
    );
    gh.factory<_i94.EditProfileDataSource>(
      () => _i642.EditProfileDataSourceImpl(apiManger: gh<_i878.ApiManger>()),
    );
    gh.factory<_i144.AuthRemoteDataSource>(
      () => _i606.AuthRemoteDataSourceImpl(apiManger: gh<_i878.ApiManger>()),
    );
    gh.factory<_i525.BrowseViewModel>(
      () => _i525.BrowseViewModel(repository: gh<_i868.BrowseTabRepository>()),
    );
    gh.factory<_i252.AuthRepository>(
      () => _i398.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i144.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i857.FavouriteRepository>(
      () => _i952.FavouriteRepositoryImpl(
        remoteDataSource: gh<_i996.FavouriteRemoteDataSource>(),
      ),
    );
    gh.factory<_i879.SearchViewModel>(
      () =>
          _i879.SearchViewModel(searchRepository: gh<_i390.SearchRepository>()),
    );
    gh.factory<_i1061.LoginViewModel>(
      () => _i1061.LoginViewModel(
        authRepository: gh<_i252.AuthRepository>(),
        userProvider: gh<_i427.UserProvider>(),
      ),
    );
    gh.factory<_i829.HomeRepository>(
      () => _i964.HomeRepositoryImpl(
        homeTabDataSource: gh<_i436.HomeTabDataSource>(),
      ),
    );

    gh.factory<_i414.ProfileViewModel>(
      () => _i414.ProfileViewModel(
        profileRepository: gh<_i634.ProfileRepository>(),
        favouriteRepository: gh<_i857.FavouriteRepository>(),

    gh.factory<_i686.EditProfileRepository>(
      () => _i85.EditProfileRepositoryImpl(
        dataSource: gh<_i94.EditProfileDataSource>(),

      ),
    );
    gh.factory<_i892.SignUpViewModel>(
      () => _i892.SignUpViewModel(authRepository: gh<_i252.AuthRepository>()),
    );
    gh.factory<_i9.EditProfileViewModel>(
      () => _i9.EditProfileViewModel(
        repository: gh<_i686.EditProfileRepository>(),
      ),
    );
    return this;
  }
}
