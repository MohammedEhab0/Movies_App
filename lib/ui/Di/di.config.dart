// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:copy_movie/api/apiManger.dart' as _i878;
import 'package:copy_movie/Data/data_sources/remote/auth_remote_data_source.dart'
    as _i144;
import 'package:copy_movie/Data/data_sources/remote/HomeTabDataSource.dart'
    as _i436;
import 'package:copy_movie/Data/data_sources/remote/Impl/auth_remote_daraSource_impl.dart'
    as _i606;
import 'package:copy_movie/Data/data_sources/remote/Impl/HomeTabDataSourceImpl.dart'
    as _i580;
import 'package:copy_movie/Data/repositories/auth/auth_repository.dart'
    as _i252;
import 'package:copy_movie/Data/repositories/auth/auth_repository_impl.dart'
    as _i398;
import 'package:copy_movie/Data/repositories/HomeRepository.dart' as _i829;
import 'package:copy_movie/Data/repositories/HomeRepositoryImpl.dart' as _i964;
import 'package:copy_movie/Providers/UserProvider.dart' as _i427;
import 'package:copy_movie/ui/auth/login/Cubit/login_view_model.dart' as _i1061;
import 'package:copy_movie/ui/auth/register/Cubit/register_view_model.dart'
    as _i892;
import 'package:copy_movie/ui/homescreen/tabs/home/Cubit/movie_view_model.dart'
    as _i498;
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
    gh.singleton<_i878.ApiManger>(() => _i878.ApiManger());
    gh.factory<_i436.HomeTabDataSource>(
      () => _i580.HomeTabDataSourceImpl(apiManger: gh<_i878.ApiManger>()),
    );
    gh.factory<_i144.AuthRemoteDataSource>(
      () => _i606.AuthRemoteDataSourceImpl(apiManger: gh<_i878.ApiManger>()),
    );
    gh.factory<_i252.AuthRepository>(
      () => _i398.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i144.AuthRemoteDataSource>(),
      ),
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
    gh.factory<_i892.RegisterViewModel>(
      () => _i892.RegisterViewModel(authRepository: gh<_i252.AuthRepository>()),
    );
    gh.factory<_i498.MoviesCubit>(
      () => _i498.MoviesCubit(homeRepository: gh<_i829.HomeRepository>()),
    );
    return this;
  }
}
