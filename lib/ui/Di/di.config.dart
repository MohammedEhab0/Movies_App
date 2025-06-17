// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../api/apiManger.dart' as _i54;
import '../../Data/data_sources/remote/auth_remote_data_source.dart' as _i783;
import '../../Data/data_sources/remote/Impl/auth_remote_daraSource_impl.dart'
    as _i920;
import '../../Data/repositories/auth/auth_repository.dart' as _i648;
import '../../Data/repositories/auth/auth_repository_impl.dart' as _i667;
import '../../Providers/UserProvider.dart' as _i957;
import '../auth/login/Cubit/login_view_model.dart' as _i51;
import '../auth/register/Cubit/register_view_model.dart' as _i927;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i957.UserProvider>(() => _i957.UserProvider());
    gh.singleton<_i54.ApiManger>(() => _i54.ApiManger());
    gh.factory<_i783.AuthRemoteDataSource>(
      () => _i920.AuthRemoteDataSourceImpl(apiManger: gh<_i54.ApiManger>()),
    );
    gh.factory<_i648.AuthRepository>(
      () => _i667.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i783.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i51.LoginViewModel>(
      () => _i51.LoginViewModel(
        authRepository: gh<_i648.AuthRepository>(),
        userProvider: gh<_i957.UserProvider>(),
      ),
    );
    gh.factory<_i927.RegisterViewModel>(
      () => _i927.RegisterViewModel(authRepository: gh<_i648.AuthRepository>()),
    );
    return this;
  }
}
