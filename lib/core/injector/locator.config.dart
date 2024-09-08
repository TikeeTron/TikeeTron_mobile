// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tikeetron_app/common/themes/cubit/theme_cubit.dart' as _i622;
import 'package:tikeetron_app/common/utils/helpers/toast_helper.dart' as _i139;
import 'package:tikeetron_app/common/utils/wallet_util.dart' as _i810;
import 'package:tikeetron_app/core/routes/app_route.dart' as _i344;
import 'package:tikeetron_app/core/services/navigation_service.dart' as _i488;
import 'package:tikeetron_app/features/create_wallet/data/repositories/implementation/walllet_core_repository_impl.dart'
    as _i223;
import 'package:tikeetron_app/features/create_wallet/data/repositories/source/local/wallet_local_repository.dart'
    as _i968;
import 'package:tikeetron_app/features/create_wallet/domain/repository/wallet_core_repository.dart'
    as _i808;
import 'package:tikeetron_app/features/create_wallet/presentation/cubit/create_wallet_cubit.dart'
    as _i772;
import 'package:tikeetron_app/features/wallet/data/repositories/implementation/tron_core_repository_impl.dart'
    as _i359;
import 'package:tikeetron_app/features/wallet/domain/repository/tron_core_repository.dart'
    as _i700;
import 'package:tikeetron_app/hive_initialization.dart' as _i1057;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i344.AppRouter>(() => _i344.AppRouter());
    gh.singleton<_i488.NavigationService>(() => _i488.NavigationService());
    gh.singleton<_i622.ThemeCubit>(() => _i622.ThemeCubit());
    gh.lazySingleton<_i968.WalletLocalRepository>(
        () => _i968.WalletLocalRepository());
    gh.lazySingleton<_i1057.HiveInitialization>(
        () => _i1057.HiveInitialization());
    gh.lazySingleton<_i810.WalletUtils>(() => _i810.WalletUtils());
    gh.lazySingleton<_i139.ToastHelper>(() => _i139.ToastHelper());
    gh.lazySingleton<_i700.TronCoreRepository>(
        () => _i359.TronCoreRepositoryImpl());
    gh.lazySingleton<_i808.WalletCoreRepository>(
        () => _i223.WallletCoreRepositoryImpl(
              gh<_i700.TronCoreRepository>(),
              gh<_i968.WalletLocalRepository>(),
            ));
    gh.lazySingleton<_i772.CreateWalletCubit>(() =>
        _i772.CreateWalletCubit(walletCore: gh<_i808.WalletCoreRepository>()));
    return this;
  }
}
