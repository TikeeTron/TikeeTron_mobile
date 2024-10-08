import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/enum/transaction_type_enum.dart';
import '../../../core/adapters/blockchain_network_adapter.dart';
import '../../../core/injector/injector.dart';
import '../../../core/routes/app_route.dart';
import '../../my_wallet/presentation/widget/history_transaction_card_widget.dart';
import '../../shared/data/model/transaction_model.dart';
import '../../shared/data/repositories/source/local/transaction_local_repository.dart';
import '../../wallet/domain/repository/wallet_core_repository.dart';
import '../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';

@RoutePage()
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<TransactionModel> txHistory = [];
  void _onTransaction({
    required TransactionModel transaction,
  }) {
    navigationService.push(
      ReceiptRoute(data: transaction),
    );
  }

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
          } else {
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
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        middle: Text(
          'Notifications',
          style: UITypographies.h4(
            context,
            color: UIColors.white50,
          ),
        ),
        trailing: BounceTap(
          onTap: () {
            context.maybePop();
          },
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: UIColors.grey200.withOpacity(0.24),
            ),
            child: Icon(
              CupertinoIcons.info_circle_fill,
              color: UIColors.white50,
              size: 20.w,
            ),
          ),
        ),
        leading: BounceTap(
          onTap: () {
            context.maybePop();
          },
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: UIColors.grey200.withOpacity(0.24),
            ),
            child: Icon(
              Icons.arrow_back,
              color: UIColors.white50,
              size: 20.w,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            HapticFeedback.mediumImpact();
            await handleTxHistory();
          },
          color: UIColors.primary500,
          child: ListView.builder(
            itemCount: txHistory.length,
            padding: EdgeInsets.only(bottom: 100.h, top: 20.h, left: 16.w, right: 16.w),
            shrinkWrap: true,
            primary: false,
            physics: const BouncingScrollPhysics(),
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
        ),
      ),
    );
  }
}
