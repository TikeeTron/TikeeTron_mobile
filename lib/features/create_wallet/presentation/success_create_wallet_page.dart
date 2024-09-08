// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../common/components/button/button_rounded_ui.dart';
// import '../../../common/components/text/auto_size_text_widget.dart';
// import '../../../common/constants/constants.dart';
// import '../../../common/constants/duration_constant.dart';
// import '../../../common/utils/extensions/object_parsing.dart';
// import '../../../common/utils/extensions/size_extension.dart';
// import '../../../common/utils/helpers/logger_helper.dart';
// import '../../../core/config/font_config.dart';
// import '../../../core/config/padding_config.dart';
// import '../../../core/injector/locator.dart';
// import '../../../core/services/navigation_service.dart';
// import '../../../core/utils/text_ui.dart';
// import '../data/model/wallet_model.dart';
// import '../domain/repository/wallet_core_repository.dart';

// class SuccessCreateWalletPageParams {
//   final WalletModel wallet;

//   const SuccessCreateWalletPageParams({
//     required this.wallet,
//   });
// }

// class SuccessCreateWalletPage extends StatefulWidget {
//   final SuccessCreateWalletPageParams params;

//   const SuccessCreateWalletPage({
//     super.key,
//     required this.params,
//   });

//   @override
//   State<SuccessCreateWalletPage> createState() => _SuccessCreateWalletPageState();
// }

// class _SuccessCreateWalletPageState extends State<SuccessCreateWalletPage> {
//   bool isAgree = false;

//   @override
//   void initState() {
//     final watchlistBloc = BlocProvider.of<WatchlistBloc>(context);
//     final Map<String, dynamic> defaultParam = {
//       "limit": ConstantConfig.tokenWatchlistLimitPerPage,
//       "sortBy": "-usd_market_cap",
//     };
//     watchlistBloc.add(GetWatchlists(params: defaultParam));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = BlocProvider.of<ThemeCubit>(context).state;

//     return CupertinoPageScaffold(
//       child: SafeArea(
//         child: Padding(
//           padding: Paddings.defaultPadding,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               const Spacer(),
//               Image.asset(
//                 ImagesConst.coinUsdt,
//                 width: (context.width ?? 0) * 0.65,
//               ),
//               const Spacer(),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextUI(
//                 'Wallet Created!',
//                 color: theme.color?.default900,
//                 weight: FontWeight.w600,
//                 fontSize: 24,
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               AutoSizeTextWidget(
//                 'You are ready to explore the blockchain world now',
//                 color: theme.color?.default500,
//                 fontSize: 16,
//                 fontFamily: FontFamily.dmSans.name,
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//               ),
//               const Spacer(),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CupertinoCheckbox(
//                         value: isAgree,
//                         onChanged: _onAgreeTermsOfService,
//                       ),
//                       AutoSizeTextWidget(
//                         'I agree to the',
//                         color: theme.color?.default600,
//                         fontSize: 16,
//                         fontFamily: FontFamily.dmSans.name,
//                         maxLines: 1,
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: _onTermsOfService,
//                     child: AutoSizeTextWidget(
//                       'Terms of Service & Privacy Policy',
//                       color: theme.color?.secondary,
//                       fontSize: 16,
//                       fontFamily: FontFamily.dmSans.name,
//                       weight: FontWeight.bold,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               ButtonRoundedUI(
//                 text: 'Get Started',
//                 useInkWell: true,
//                 useHeavyHaptic: true,
//                 color: theme.color?.secondary,
//                 disabled: !isAgree,
//                 onPress: _onGetStarted,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _onAgreeTermsOfService(bool? value) {
//     setState(() {
//       isAgree = value ?? !isAgree;
//     });
//   }

//   void _onTermsOfService() {
//     // locator<NavigationServices>().pushNamed(
//     //   AppRoute.webview.path,
//     //   arguments: WebviewPageParams(
//     //     uri: env.xellarPrivacyPolicyUrl.toUri,
//     //     siteTitle: 'Terms of Service & Privacy Policy',
//     //   ),
//     // );
//   }

//   Future<void> _onGetStarted() async {
//     try {
//       if (mounted) {
//         // show full screen loading
//         context.showFullScreenLoading;
//       }

//       // if wallet type not cold, save wallet to local
//       await _onSaveWallets();

//       // get wallets
//       BlocProvider.of<WalletsCubit>(context).getWallets();

//       // set active wallet
//       await BlocProvider.of<ActiveWalletCubit>(context).setActiveWallet(
//         wallet: widget.params.wallet,
//       );
//       final activeWalletCubit = BlocProvider.of<ActiveWalletCubit>(context).state;
//       final watchlistBloc = BlocProvider.of<WatchlistBloc>(context);
//       if (activeWalletCubit.walletIndex != null) {
//         List<dynamic> tokenList = watchlistBloc.state.watchlists ?? [];
//         if (tokenList.isNotEmpty) {
//           for (var item in tokenList) {
//             var mapData = (item as Map).toMapString;

//             final tokenData = mapData.maybeWhere((e) {
//               return e['id'] == 'bitcoin' || e['id'] == 'ethereum' || e['id'] == 'solana' || e['id'] == 'tether' || e['id'] == 'usd-coin';
//             })?.toMapString;
//             if (tokenData != null) {
//               await locator<TokenWatchlistLocalDataSource>().addWatchList(
//                 walletIndex: activeWalletCubit.walletIndex ?? 0,
//                 tokenData: tokenData,
//               );
//             }
//           }
//         }
//       }

//       await Future.delayed(DurationConstant.d500);
//       // go to main page
//       // locator<NavigationService>().pushNamedAndRemoveUntil(
//       //   AppRoute.main.path,
//       // );
//     } catch (error) {
//       Logger.error(error.errorMessage);
//     } finally {
//       Future.delayed(const Duration(milliseconds: 700), () {
//         return BlocProvider.of<FullScreenLoadingCubit>(locator<NavigationService>().currentContext!).hideFullScreenLoading();
//       });
//     }
//   }

//   Future<void> _onSaveWallets() async {
//     try {
//       await locator<WalletCoreRepository>().saveWallet(
//         wallet: widget.params.wallet,
//       );
//     } catch (_) {
//       rethrow;
//     }
//   }
// }
