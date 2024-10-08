import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../common/common.dart';
import '../../../../common/components/empty_data/empty_data_widget.dart';
import '../../../../common/constants/constants.dart';
import '../../../../common/enum/transaction_type_enum.dart';
import '../../../../core/adapters/blockchain_network_adapter.dart';
import '../../../../core/core.dart';
import '../../../../core/injector/injector.dart';
import '../../../shared/data/model/transaction_model.dart';
import '../../../shared/data/repositories/source/local/transaction_local_repository.dart';
import '../../../wallet/domain/repository/wallet_core_repository.dart';
import '../../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';
import '../widget/history_transaction_card_widget.dart';

class WalletActivityTabBarView extends StatefulWidget {
  const WalletActivityTabBarView({super.key});

  @override
  State<WalletActivityTabBarView> createState() => _WalletActivityTabBarViewState();
}

class _WalletActivityTabBarViewState extends State<WalletActivityTabBarView> {
  List<TransactionModel> txHistory = [];

  @override
  void initState() {
    handleTxHistory();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> handleTxHistory() async {
    final transactionRepository = locator<TransactionLocalRepository>();

    final transactions = transactionRepository.getAll();
    if (transactions == null || transactions.isEmpty) {
      return;
    }

    final temp = List<TransactionModel>.from(transactions.map((e) {
      return TransactionModel.fromJson(e);
    }).toList());
    for (var history in temp) {
      try {
        DateFormat('MMMM dd yyyy, hh:mm a').parse(history.date ?? '');
      } catch (e) {
        temp.removeWhere((element) {
          return element.date == history.date;
        });
      }
    }

    // Sort by date
    temp.sort((a, b) {
      var adate = DateFormat('MMMM dd yyyy, hh:mm a').parse(a.date ?? '');
      var bdate = DateFormat('MMMM dd yyyy, hh:mm a').parse(b.date ?? '');

      return bdate.compareTo(adate);
    });

    final activeWallet = BlocProvider.of<ActiveWalletCubit>(context).state.wallet!;

    for (final transaction in temp) {
      try {
        if (activeWallet.addresses?.where((element) => element.address == transaction.fromAddress).isNotEmpty ?? true) {
          final walletAddress = locator<WalletCoreRepository>().getWalletAddress(
            wallet: activeWallet,
            blockchain: BlockchainNetwork.tron,
          );

          final from = transaction.fromAddress;
          final to = transaction.toAddress;
          final txDirection = transaction.transactionType;

          if (from == walletAddress && txDirection == TransactionTypeEnum.send) {
            txHistory.add(transaction);
          } else if (to == walletAddress && txDirection == TransactionTypeEnum.receive) {
            txHistory.add(transaction);
          }
        }
      } catch (e) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (txHistory.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          HapticFeedback.mediumImpact();
          await handleTxHistory();
        },
        child: const SingleChildScrollView(
          child: Column(
            children: [
              const EmptyDataWidget(
                image: IconsConst.icEmptyActivity,
                title: 'No recent activity',
                desc: 'Your transaction history will appear here once you start using your wallet.',
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        await handleTxHistory();
      },
      color: UIColors.primary500,
      child: ListView.builder(
        itemCount: txHistory.length,
        padding: EdgeInsets.only(bottom: 100.h),
        shrinkWrap: true,
        physics: const RangeMaintainingScrollPhysics(),
        primary: false,
        itemBuilder: (context, index) {
          final transaction = txHistory[index];

          return Padding(
            padding: EdgeInsets.only(
              top: 16.h,
              bottom: 0,
            ),
            child: HistoryTransactionCardWidget(
              data: transaction,
              onTap: () {
                _onTransaction(
                  transaction: transaction,
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onTransaction({
    required TransactionModel transaction,
  }) {
    navigationService.push(
      ReceiptRoute(data: transaction),
    );
  }
}
