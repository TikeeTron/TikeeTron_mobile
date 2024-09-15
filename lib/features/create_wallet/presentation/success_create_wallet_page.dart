import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/common.dart';
import '../../../common/components/button/button_rounded_ui.dart';
import '../../../common/config/padding_config.dart';
import '../../../common/constants/constants.dart';
import '../../../common/constants/duration_constant.dart';
import '../../../common/themes/colors.dart';
import '../../../common/themes/typographies.dart';
import '../../../common/utils/extensions/object_parsing.dart';
import '../../../common/utils/extensions/size_extension.dart';
import '../../../common/utils/helpers/logger_helper.dart';
import '../../../common/utils/utils.dart';
import '../../../core/injector/locator.dart';
import '../../../core/services/navigation_service.dart';
import '../data/model/wallet_model.dart';
import '../domain/repository/wallet_core_repository.dart';

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
    // final watchlistBloc = BlocProvider.of<WatchlistBloc>(context);
    // final Map<String, dynamic> defaultParam = {
    //   "limit": ConstantConfig.tokenWatchlistLimitPerPage,
    //   "sortBy": "-usd_market_cap",
    // };
    // watchlistBloc.add(GetWatchlists(params: defaultParam));
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
                onPressed: () {},
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

  void _onAgreeTermsOfService(bool? value) {
    setState(() {
      isAgree = value ?? !isAgree;
    });
  }

  void _onTermsOfService() {
    // locator<NavigationServices>().pushNamed(
    //   AppRoute.webview.path,
    //   arguments: WebviewPageParams(
    //     uri: env.xellarPrivacyPolicyUrl.toUri,
    //     siteTitle: 'Terms of Service & Privacy Policy',
    //   ),
    // );
  }

  Future<void> _onGetStarted() async {
    try {
      // if wallet type not cold, save wallet to local
      await _onSaveWallets();

      // get wallets
      // BlocProvider.of<WalletsCubit>(context).getWallets();

      // // set active wallet
      // await BlocProvider.of<ActiveWalletCubit>(context).setActiveWallet(
      //   wallet: widget.params.wallet,
      // );
      // final activeWalletCubit = BlocProvider.of<ActiveWalletCubit>(context).state;
      // final watchlistBloc = BlocProvider.of<WatchlistBloc>(context);
      // if (activeWalletCubit.walletIndex != null) {
      //   List<dynamic> tokenList = watchlistBloc.state.watchlists ?? [];
      //   if (tokenList.isNotEmpty) {
      //     for (var item in tokenList) {
      //       var mapData = (item as Map).toMapString;

      //       final tokenData = mapData.maybeWhere((e) {
      //         return e['id'] == 'bitcoin' || e['id'] == 'ethereum' || e['id'] == 'solana' || e['id'] == 'tether' || e['id'] == 'usd-coin';
      //       })?.toMapString;
      //       if (tokenData != null) {
      //         await locator<TokenWatchlistLocalDataSource>().addWatchList(
      //           walletIndex: activeWalletCubit.walletIndex ?? 0,
      //           tokenData: tokenData,
      //         );
      //       }
      //     }
      //   }
      // }

      await Future.delayed(DurationConstant.d500);
      // go to main page
      // locator<NavigationService>().pushNamedAndRemoveUntil(
      //   AppRoute.main.path,
      // );
    } catch (error) {
      Logger.error(error.errorMessage);
    } finally {}
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
