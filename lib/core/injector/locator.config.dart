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
import 'package:tikeetron_app/common/utils/helpers/debouncer_helper.dart'
    as _i196;
import 'package:tikeetron_app/common/utils/helpers/toast_helper.dart' as _i139;
import 'package:tikeetron_app/common/utils/wallet_util.dart' as _i810;
import 'package:tikeetron_app/core/app/app_repository.dart' as _i258;
import 'package:tikeetron_app/core/routes/app_route.dart' as _i344;
import 'package:tikeetron_app/core/services/navigation_service.dart' as _i488;
import 'package:tikeetron_app/features/blockchain/data/repositories/implementation/tron_core_repository_impl.dart'
    as _i111;
import 'package:tikeetron_app/features/blockchain/data/repositories/source/tron_remote.dart'
    as _i446;
import 'package:tikeetron_app/features/blockchain/domain/repository/tron_core_repository.dart'
    as _i1041;
import 'package:tikeetron_app/features/buy_ticket/presentation/cubit/buy_ticket_quoting_cubit.dart'
    as _i531;
import 'package:tikeetron_app/features/buy_ticket/presentation/cubit/confirm_buy_ticket_cubit.dart'
    as _i174;
import 'package:tikeetron_app/features/buy_ticket/presentation/cubit/get_list_event_ticket_cubit.dart'
    as _i1072;
import 'package:tikeetron_app/features/home/data/repositories/implementation/ai_repository_implementation.dart'
    as _i662;
import 'package:tikeetron_app/features/home/data/repositories/implementation/event_repository_implementation.dart'
    as _i68;
import 'package:tikeetron_app/features/home/data/repositories/implementation/ticket_repository_implementation.dart'
    as _i788;
import 'package:tikeetron_app/features/home/data/repositories/source/remote/ai_remote.dart'
    as _i303;
import 'package:tikeetron_app/features/home/data/repositories/source/remote/event_remote.dart'
    as _i679;
import 'package:tikeetron_app/features/home/data/repositories/source/remote/ticket_remote.dart'
    as _i470;
import 'package:tikeetron_app/features/home/domain/repository/ai_repository.dart'
    as _i306;
import 'package:tikeetron_app/features/home/domain/repository/event_repository.dart'
    as _i137;
import 'package:tikeetron_app/features/home/domain/repository/ticket_repository.dart'
    as _i441;
import 'package:tikeetron_app/features/home/presentation/cubit/ask_ai_cubit.dart'
    as _i589;
import 'package:tikeetron_app/features/home/presentation/cubit/get_list_event_cubit.dart'
    as _i39;
import 'package:tikeetron_app/features/home/presentation/cubit/get_list_user_ticket_cubit.dart'
    as _i185;
import 'package:tikeetron_app/features/send/presentation/cubit/send_token_cubit.dart'
    as _i632;
import 'package:tikeetron_app/features/send/presentation/cubit/send_token_quoting_cubit.dart'
    as _i259;
import 'package:tikeetron_app/features/send/presentation/cubit/ticket/send_ticket_cubit.dart'
    as _i528;
import 'package:tikeetron_app/features/send/presentation/cubit/ticket/send_ticket_quoting_cubit.dart'
    as _i16;
import 'package:tikeetron_app/features/shared/data/repositories/implementation/transaction_repository_implementation.dart'
    as _i380;
import 'package:tikeetron_app/features/shared/data/repositories/source/local/transaction_local_repository.dart'
    as _i720;
import 'package:tikeetron_app/features/shared/domain/transaction_repository.dart'
    as _i1047;
import 'package:tikeetron_app/features/shared/presentation/cubit/dashboard_cubit.dart'
    as _i542;
import 'package:tikeetron_app/features/shared/presentation/cubit/loading/fullscreen_loading_cubit.dart'
    as _i80;
import 'package:tikeetron_app/features/shared/presentation/cubit/pin/pin_cubit.dart'
    as _i862;
import 'package:tikeetron_app/features/shared/presentation/cubit/theme_cubit.dart'
    as _i714;
import 'package:tikeetron_app/features/wallet/data/repositories/implementation/token_core_repository_impl.dart'
    as _i48;
import 'package:tikeetron_app/features/wallet/data/repositories/implementation/walllet_core_repository_impl.dart'
    as _i678;
import 'package:tikeetron_app/features/wallet/data/repositories/source/local/account_local_repository.dart'
    as _i436;
import 'package:tikeetron_app/features/wallet/data/repositories/source/local/wallet_local_repository.dart'
    as _i593;
import 'package:tikeetron_app/features/wallet/domain/repository/token_core_repository.dart'
    as _i592;
import 'package:tikeetron_app/features/wallet/domain/repository/wallet_core_repository.dart'
    as _i183;
import 'package:tikeetron_app/features/wallet/presentation/create_wallet/cubit/create_wallet_cubit.dart'
    as _i671;
import 'package:tikeetron_app/features/wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart'
    as _i878;
import 'package:tikeetron_app/features/wallet/presentation/cubit/token_list/token_list_cubit.dart'
    as _i546;
import 'package:tikeetron_app/features/wallet/presentation/cubit/wallets/wallets_cubit.dart'
    as _i693;
import 'package:tikeetron_app/features/wallet/presentation/import_wallet/cubit/import_wallet_cubit.dart'
    as _i89;
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
    gh.singleton<_i714.ThemeCubit>(() => _i714.ThemeCubit());
    gh.singleton<_i542.DashboardCubit>(() => _i542.DashboardCubit());
    gh.singleton<_i622.ThemeCubit>(() => _i622.ThemeCubit());
    gh.lazySingleton<_i679.EventRemote>(() => _i679.EventRemote());
    gh.lazySingleton<_i303.AiRemote>(() => _i303.AiRemote());
    gh.lazySingleton<_i470.TicketRemote>(() => _i470.TicketRemote());
    gh.lazySingleton<_i720.TransactionLocalRepository>(
        () => _i720.TransactionLocalRepository());
    gh.lazySingleton<_i862.PinCubit>(() => _i862.PinCubit());
    gh.lazySingleton<_i80.FullScreenLoadingCubit>(
        () => _i80.FullScreenLoadingCubit());
    gh.lazySingleton<_i446.TronRemote>(() => _i446.TronRemote());
    gh.lazySingleton<_i593.WalletLocalRepository>(
        () => _i593.WalletLocalRepository());
    gh.lazySingleton<_i436.AccountLocalRepository>(
        () => _i436.AccountLocalRepository());
    gh.lazySingleton<_i1057.HiveInitialization>(
        () => _i1057.HiveInitialization());
    gh.lazySingleton<_i810.WalletUtils>(() => _i810.WalletUtils());
    gh.lazySingleton<_i196.Debouncer>(() => _i196.Debouncer());
    gh.lazySingleton<_i139.ToastHelper>(() => _i139.ToastHelper());
    gh.lazySingleton<_i258.BaseRepository>(
        () => _i258.AppRepository(gh<String>()));
    gh.lazySingleton<_i1047.TransactionRepository>(
        () => _i380.TransactionRepositoryImplementation(
              gh<_i720.TransactionLocalRepository>(),
              gh<_i446.TronRemote>(),
            ));
    gh.lazySingleton<_i1041.TronCoreRepository>(
        () => _i111.TronCoreRepositoryImpl(
              gh<_i446.TronRemote>(),
              gh<_i436.AccountLocalRepository>(),
            ));
    gh.lazySingleton<_i441.TicketRepository>(
        () => _i788.TicketRepositoryImplementation(
              gh<_i470.TicketRemote>(),
              gh<_i436.AccountLocalRepository>(),
            ));
    gh.lazySingleton<_i137.EventRepository>(
        () => _i68.EventRepositoryImplementation(
              gh<_i679.EventRemote>(),
              gh<_i436.AccountLocalRepository>(),
            ));
    gh.lazySingleton<_i39.GetListEventCubit>(
        () => _i39.GetListEventCubit(gh<_i137.EventRepository>()));
    gh.lazySingleton<_i1072.GetListEventTicketCubit>(
        () => _i1072.GetListEventTicketCubit(gh<_i137.EventRepository>()));
    gh.lazySingleton<_i306.AiRepository>(
        () => _i662.AiRepositoryImplementation(gh<_i303.AiRemote>()));
    gh.lazySingleton<_i185.GetListUserTicketCubit>(
        () => _i185.GetListUserTicketCubit(gh<_i441.TicketRepository>()));
    gh.lazySingleton<_i183.WalletCoreRepository>(
        () => _i678.WallletCoreRepositoryImpl(
              gh<_i1041.TronCoreRepository>(),
              gh<_i593.WalletLocalRepository>(),
              gh<_i436.AccountLocalRepository>(),
            ));
    gh.lazySingleton<_i592.TokenCoreRepository>(
        () => _i48.TokenCoreRepositoryImpl(
              tronCore: gh<_i1041.TronCoreRepository>(),
              walletCore: gh<_i183.WalletCoreRepository>(),
              accountLocalRepository: gh<_i436.AccountLocalRepository>(),
            ));
    gh.lazySingleton<_i878.ActiveWalletCubit>(() => _i878.ActiveWalletCubit(
          accountLocalRepository: gh<_i436.AccountLocalRepository>(),
          walletCore: gh<_i183.WalletCoreRepository>(),
          tronCoreRepository: gh<_i1041.TronCoreRepository>(),
          walletCoreRepository: gh<_i183.WalletCoreRepository>(),
        ));
    gh.lazySingleton<_i174.ConfirmBuyTicketCubit>(
        () => _i174.ConfirmBuyTicketCubit(
              gh<_i1041.TronCoreRepository>(),
              gh<_i1047.TransactionRepository>(),
            ));
    gh.lazySingleton<_i632.SendTokenCubit>(() => _i632.SendTokenCubit(
          gh<_i1041.TronCoreRepository>(),
          gh<_i1047.TransactionRepository>(),
        ));
    gh.lazySingleton<_i528.SendTicketCubit>(() => _i528.SendTicketCubit(
          gh<_i1041.TronCoreRepository>(),
          gh<_i1047.TransactionRepository>(),
        ));
    gh.lazySingleton<_i589.AskAiCubit>(
        () => _i589.AskAiCubit(gh<_i306.AiRepository>()));
    gh.lazySingleton<_i546.TokenListCubit>(
        () => _i546.TokenListCubit(tokenCore: gh<_i592.TokenCoreRepository>()));
    gh.lazySingleton<_i531.BuyTicketQuotingCubit>(
        () => _i531.BuyTicketQuotingCubit(gh<_i1041.TronCoreRepository>()));
    gh.lazySingleton<_i259.SendTokenQuotingCubit>(
        () => _i259.SendTokenQuotingCubit(gh<_i1041.TronCoreRepository>()));
    gh.lazySingleton<_i16.SendTicketQuotingCubit>(
        () => _i16.SendTicketQuotingCubit(gh<_i1041.TronCoreRepository>()));
    gh.lazySingleton<_i693.WalletsCubit>(
        () => _i693.WalletsCubit(walletCore: gh<_i183.WalletCoreRepository>()));
    gh.lazySingleton<_i671.CreateWalletCubit>(() =>
        _i671.CreateWalletCubit(walletCore: gh<_i183.WalletCoreRepository>()));
    gh.lazySingleton<_i89.ImportWalletCubit>(() =>
        _i89.ImportWalletCubit(walletCore: gh<_i183.WalletCoreRepository>()));
    return this;
  }
}
