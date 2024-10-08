import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/components.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../common/config/padding_config.dart';
import '../../../../common/constants/assets_const.dart';
import '../../../../common/themes/colors.dart';
import '../../../../common/themes/typographies.dart';
import '../../../../common/utils/extensions/context_parsing.dart';
import '../../../../common/utils/utils.dart';
import '../../../../core/core.dart';
import '../../../../core/injector/locator.dart';
import '../../../shared/presentation/scan_qr_bottom_sheet.dart';
import '../../domain/repository/wallet_core_repository.dart';
import '../cubit/active_wallet/active_wallet_cubit.dart';
import '../cubit/wallets/wallets_cubit.dart';
import 'cubit/import_wallet_cubit.dart';

@RoutePage()
class ImportWalletPage extends StatefulWidget {
  const ImportWalletPage({super.key});

  @override
  State<ImportWalletPage> createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {
  final _seedPhraseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => locator<ImportWalletCubit>(),
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        navigationBar: ScaffoldAppBar.cupertino(
          context,
          title: '',
          trailing: BounceTap(
            onTap: () async {
              final scanQrResult = await ModalHelper.showModalBottomSheet(
                context,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.1,
                  decoration: BoxDecoration(
                    color: UIColors.black400,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      topLeft: Radius.circular(16.r),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text(
                          'Scan QR',
                          style: UITypographies.h4(context),
                        ),
                      ),
                      const ScanQrBottomSheet(),
                    ],
                  ),
                ),
                padding: EdgeInsets.zero,
              );
              _seedPhraseController.text = scanQrResult.toString();
            },
            child: SvgUI(
              SvgConst.scanQr,
              color: UIColors.white50,
              width: 32.w,
              height: 32.w,
            ),
          ),
        ),
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: Paddings.defaultPaddingH,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Import Your Wallet',
                    style: UITypographies.h4(context, fontSize: 28.sp),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Enter your seed phrase to restore your wallet and access your tickets.',
                    style: UITypographies.bodyLarge(
                      context,
                      color: UIColors.grey500,
                      fontSize: 15.sp,
                    ),
                  ),
                  UIGap.size(h: 40.h),
                  Expanded(
                    child: UITextField(
                      textController: _seedPhraseController,
                      fillColor: UIColors.black400,
                      keyboardType: TextInputType.multiline,
                      hint: 'Enter recovery phrase',
                      borderColor: UIColors.white50.withOpacity(0.15),
                      maxLines: 6,
                      onChanged: (_) {
                        setState(() {});
                      },
                    ),
                  ),
                  UIPrimaryButton(
                    text: 'Continue',
                    size: UIButtonSize.large,
                    onPressed: _seedPhraseController.text.isNotEmpty
                        ? () async {
                            context.showFullScreenLoadingWithMessage('Processing your', 'wallet information');
                            final importedWallet = await BlocProvider.of<ImportWalletCubit>(context).importWallet(
                              _seedPhraseController.text,
                            );
                            // save wallet to local repository
                            await locator<WalletCoreRepository>().saveWallet(
                              wallet: importedWallet,
                            );

                            // get wallets
                            BlocProvider.of<WalletsCubit>(context).getWallets();

                            // // set active wallet
                            await BlocProvider.of<ActiveWalletCubit>(context).setActiveWallet(
                              wallet: importedWallet,
                            );
                            navigationService.pushAndPopUntil(
                              const DashboardRoute(),
                              predicate: (p0) => false,
                            );
                            context.hideFullScreenLoading;
                          }
                        : null,
                  ),
                  UIGap.h20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
