import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/container/grabber_container.dart';
import '../../../../common/components/dialogs/confirmation_alert_widget.dart';
import '../../../../common/utils/extensions/context_parsing.dart';
import '../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../core/core.dart';
import '../../../../core/injector/locator.dart';
import '../../../wallet/data/model/wallet_model.dart';
import '../../../wallet/domain/repository/wallet_core_repository.dart';
import '../../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import 'list_account_card_widget.dart';

class AccountModal extends StatelessWidget {
  final void Function()? onAddWallet;
  final List<WalletModel> listWallet;
  final WalletModel activeWallet;
  const AccountModal({
    super.key,
    this.onAddWallet,
    required this.listWallet,
    required this.activeWallet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: UIColors.black400,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: const GrabberContainer(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 37.h),
            child: Text(
              'Your Accounts',
              textAlign: TextAlign.center,
              style: UITypographies.h4(
                context,
              ),
            ),
          ),
          UIGap.h16,
          UIDivider(
            color: UIColors.white50.withOpacity(0.15),
            thickness: 1.r,
          ),
          UIGap.size(h: 20.h),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 200.h),
            child: Column(
              children: List.generate(
                listWallet.length,
                (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: ListAccountCardWidget(
                      isActive: activeWallet.addresses?[0].address == listWallet[index].addresses?[0].address,
                      walletAddress: listWallet[index].addresses?[0].address ?? '',
                      walletName: listWallet[index].name ?? '',
                      onLogOut: () async {
                        final confirm = await ModalHelper.showModalBottomSheet(
                          context,
                          padding: EdgeInsets.zero,
                          child: ConfirmationAlertWidget(
                            onClose: () {
                              Navigator.pop(context, false);
                            },
                            onConfirm: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        );
                        if (confirm ?? false) {
                          // get wallet address
                          final walletAddress = locator<WalletCoreRepository>().getWalletAddress(
                            wallet: listWallet[index],
                            blockchain: BlockchainNetwork.tron,
                          );

                          // delete wallet
                          await locator<WalletCoreRepository>().deleteWallet(
                            walletIndex: index,
                            walletAddress: walletAddress,
                          );
                          final totalWallet = locator<WalletCoreRepository>().getWallets();
                          if (totalWallet.isEmpty) {
                            navigationService.pushAndPopUntil(
                              const OnBoardingRoute(),
                              predicate: (p0) => false,
                            );
                          } else {
                            navigationService.pushAndPopUntil(
                              const DashboardRoute(),
                              predicate: (p0) => false,
                            );
                          }
                        }
                      },
                      onChangeAccount: () async {
                        context.showFullScreenLoadingWithMessage('Loading...', 'Switch Wallet');
                        await BlocProvider.of<ActiveWalletCubit>(context).setActiveWallet(
                          wallet: listWallet[index],
                        );
                        navigationService.pushAndPopUntil(
                          const DashboardRoute(),
                          predicate: (p0) => false,
                        );
                        context.hideFullScreenLoading;
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: UIPrimaryButton(
                text: 'Add / Connect Wallet',
                textStyle: UITypographies.bodyLarge(context),
                size: UIButtonSize.large,
                borderRadius: BorderRadius.circular(12.r),
                onPressed: onAddWallet,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
