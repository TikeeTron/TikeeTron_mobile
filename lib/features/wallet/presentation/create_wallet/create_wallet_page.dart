import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../../common/components/button/sliver_button_bottom_widget.dart';
import '../../../../common/constants/duration_constant.dart';
import '../../../../common/utils/encrypter/encrypter.dart';
import '../../../../common/utils/helpers/logger_helper.dart';
import '../../data/model/wallet_model.dart';
import '../widget/back_up_step_page_view.dart';
import '../widget/confirm_step_page_view.dart';
import 'cubit/create_wallet_cubit.dart';

@RoutePage()
class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({super.key});

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  @override
  Widget build(BuildContext context) {
    return const _MainWidget();
  }
}

class _MainWidget extends StatefulWidget {
  const _MainWidget();

  @override
  State<_MainWidget> createState() => __MainWidgetState();
}

class __MainWidgetState extends State<_MainWidget> {
  late PageController _pageController;
  int _currentPage = 0;

  bool isLoading = false;

  List<String> _mnemonicWords = [];
  WalletModel? _wallet;

  @override
  void initState() {
    _onCreateWallet();
    _pageController = PageController(
      keepPage: true,
      initialPage: _currentPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        title: '',
      ),
      child: SafeArea(
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (page) {
                // callback change page
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                BackUpStepPageView(
                  mnemonicWords: _mnemonicWords,
                ),
                ConfirmStepPageView(
                  mnemonicWords: _mnemonicWords,
                  wallet: _wallet,
                ),
              ],
            ),
            if (_currentPage != 1)
              _BottomButtonWidget(
                currentPage: _currentPage,
                isLoading: isLoading,
                wallet: _wallet,
                onChangePage: (page) {
                  _onChangeToPage(page);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onChangeToPage(int page) async {
    try {
      // change page
      _pageController.animateToPage(
        page,
        duration: DurationConstant.d300,
        curve: Curves.ease,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _onCreateWallet() async {
    try {
      setState(() {
        isLoading = true;
      });

      // create wallet
      _wallet = await BlocProvider.of<CreateWalletCubit>(context).createWallet();

      // decrypt seed
      final String? seed = _wallet?.seed;
      final descryptedSeed = EncryptEngine.decryptData(seed);

      // set mnemonic words
      final mnemonicWords = descryptedSeed.split(' ');
      _mnemonicWords = mnemonicWords;
    } catch (error) {
      Logger.error(error.toString());

      rethrow;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class _BottomButtonWidget extends StatefulWidget {
  final int? currentPage;
  final bool isLoading;
  final WalletModel? wallet;
  final Function(int) onChangePage;

  const _BottomButtonWidget({
    required this.currentPage,
    required this.isLoading,
    required this.wallet,
    required this.onChangePage,
  });

  @override
  State<_BottomButtonWidget> createState() => _BottomButtonWidgetState();
}

class _BottomButtonWidgetState extends State<_BottomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    String? title;
    Function()? onTap;
    if (widget.currentPage == 0) {
      title = 'Continue';
      onTap = () {
        // callback change page
        widget.onChangePage(1);
      };
    } else if (widget.currentPage == 1) {
      title = 'Continue';
      onTap = () {
        // callback change page
        widget.onChangePage(2);
      };
    }

    if (title == null || onTap == null) {
      return const SizedBox.shrink();
    }

    return SliverButtonBottomWidget(
      title: title,
      isLoading: widget.isLoading,
      onTap: onTap,
    );
  }
}
