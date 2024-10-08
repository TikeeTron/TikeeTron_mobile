import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/config/padding_config.dart';
import '../../../../common/constants/duration_constant.dart';
import '../../../../common/utils/extensions/context_parsing.dart';
import '../../../../common/utils/extensions/object_parsing.dart';

import '../../../../common/utils/helpers/logger_helper.dart';
import '../../../../core/injector/locator.dart';
import '../../../../core/routes/app_route.dart';
import '../../../shared/presentation/cubit/pin/pin_cubit.dart';
import '../../data/model/wallet_model.dart';
import '../../data/repositories/source/local/account_local_repository.dart';
import '../../domain/repository/wallet_core_repository.dart';
import '../cubit/active_wallet/active_wallet_cubit.dart';
import '../cubit/wallets/wallets_cubit.dart';

class SuccessCreateWalletPageParams {
  final WalletModel wallet;

  const SuccessCreateWalletPageParams({
    required this.wallet,
  });
}

@RoutePage()
class SuccessCreateWalletPage extends StatefulWidget {
  final SuccessCreateWalletPageParams params;

  const SuccessCreateWalletPage({
    super.key,
    required this.params,
  });

  @override
  State<SuccessCreateWalletPage> createState() => _SuccessCreateWalletPageState();
}

class _SuccessCreateWalletPageState extends State<SuccessCreateWalletPage> {
  bool isAgree = false;

  @override
  void initState() {
    final accountRepository = locator<AccountLocalRepository>();
    final haveAppLock = accountRepository.getUserPin();
    if (haveAppLock.isNotEmpty) {
      _onGetStarted();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: Paddings.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Protect your wallet',
                style: UITypographies.h4(context, fontSize: 28.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                'This extra layer of security helps prevent someone with access to your phone.',
                style: UITypographies.bodyLarge(
                  context,
                  color: UIColors.grey500,
                  fontSize: 15.sp,
                ),
              ),
              const Spacer(),
              UIPrimaryButton(
                text: 'Use Pin Code',
                size: UIButtonSize.large,
                onPressed: () async {
                  BlocProvider.of<PinCubit>(context).checkLocalAuth();
                  await _onGetStarted();
                },
              ),
              SizedBox(height: 10.h),
              UIFadeButton(
                onTap: _onGetStarted,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Center(
                    child: Text(
                      'Skip for now',
                      style: UITypographies.bodyLarge(
                        context,
                        fontSize: 17.sp,
                        color: UIColors.primary500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onGetStarted() async {
    try {
      context.showFullScreenLoadingWithMessage('Creating Your Wallet', '');
      // if wallet type not cold, save wallet to local
      await _onSaveWallets();

      if (!mounted) return;
      // get wallets
      BlocProvider.of<WalletsCubit>(context).getWallets();

      // // set active wallet
      await BlocProvider.of<ActiveWalletCubit>(context).setActiveWallet(
        wallet: widget.params.wallet,
      );
      await Future.delayed(DurationConstant.d500);
      // go to main page
      navigationService.pushAndPopUntil(
        const DashboardRoute(),
        predicate: (route) => false,
      );
    } catch (error) {
      Logger.error(error.errorMessage);
    } finally {
      context.hideFullScreenLoading;
    }
  }

  Future<void> _onSaveWallets() async {
    try {
      await locator<WalletCoreRepository>().saveWallet(
        wallet: widget.params.wallet,
      );
    } catch (_) {
      rethrow;
    }
  }
}
