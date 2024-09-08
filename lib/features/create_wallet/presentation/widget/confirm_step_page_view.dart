import 'dart:math';

import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../../common/common.dart';
import '../../../../common/config/padding_config.dart';
import '../../../../common/utils/extensions/list_string_parsing.dart';
import '../../../../common/utils/extensions/size_extension.dart';
import '../../../../common/utils/helpers/logger_helper.dart';
import '../../../../common/components/text/text_ui.dart';
import '../../data/model/wallet_model.dart';
import 'seed_phrase_item_widget.dart';

class ConfirmStepPageView extends StatefulWidget {
  final List<String> mnemonicWords;
  final WalletModel? wallet;

  const ConfirmStepPageView({
    super.key,
    required this.mnemonicWords,
    required this.wallet,
  });

  @override
  State<ConfirmStepPageView> createState() => _ConfirmStepPageViewState();
}

class _ConfirmStepPageViewState extends State<ConfirmStepPageView> {
  List<String> mnemonicWords = [];
  List<String> shuffledMnenomicWords = [];
  List<int> confirmedMnemonicIndex = [];

  int _currentIndex = 0;
  String _currentWord = '';

  String? _errorText;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    mnemonicWords = widget.mnemonicWords;

    // shuffle mnemonic words
    _shuffleMnemonic();
  }

  void _shuffleMnemonic() {
    final mnemonic = List<String>.from(mnemonicWords);

    // shake mnemonic words
    mnemonic.shuffle();

    shuffledMnenomicWords = mnemonic;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.defaultPaddingH,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            TextUI(
              'Confirm seed phrase',
              overwriteStyle: context.theme.textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            TextUI(
              'Select each word in the order as presented to you previously',
              overwriteStyle: context.theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              width: context.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF34373E),
                ),
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF1F2025),
              ),
              child: Row(
                children: [
                  ShowUpAnimation(
                    delayStart: Duration.zero,
                    animationDuration: const Duration(milliseconds: 300),
                    curve: Curves.bounceIn,
                    direction: Direction.vertical,
                    key: ValueKey(Random()),
                    offset: 0.5,
                    child: TextUI(
                      "${_currentIndex + 1}.",
                      overwriteStyle: context.theme.textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ShowUpAnimation(
                    delayStart: Duration.zero,
                    animationDuration: const Duration(milliseconds: 300),
                    curve: Curves.bounceIn,
                    direction: Direction.vertical,
                    key: ValueKey(Random()),
                    offset: 0.5,
                    child: TextUI(
                      _currentWord,
                      overwriteStyle: context.theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            if (mnemonicWords.isContainSameElement) ...[
              const SizedBox(
                height: 8,
              ),
              TextUI(
                'You might see the same words appeared within the seed phrase generated',
                overwriteStyle: context.theme.textTheme.labelMedium,
              ),
            ],
            if (_errorText != null && _errorText!.isNotEmpty) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: Paddings.l12,
                    child: TextUI(
                      _errorText!,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: shuffledMnenomicWords.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final word = shuffledMnenomicWords[index];
                  final isConfirmed = confirmedMnemonicIndex.contains(index);

                  return SeedPhraseItemWidget(
                    text: word,
                    isConfirmed: isConfirmed,
                    onTap: (isConfirmed)
                        ? null
                        : () => _onSelectWord(
                              index: index,
                              word: word,
                            ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSelectWord({
    required int index,
    required String word,
  }) async {
    setState(() {
      _currentWord = word;
    });

    // validate word
    final isValid = validateMnemonicWord(
      mnemonicWord: word,
    );

    if (!isValid) {
      setState(() {
        _errorText = 'Invalid word';
        _currentWord = '';
      });

      return;
    }

    // next step
    if ((_currentIndex + 1) == mnemonicWords.length) {
      // go to success create wallet page
      // locator<NavigationService>().pushReplacementNamed(
      //   AppRoute.successCreateWallet.path,
      //   arguments: SuccessCreateWalletPageParams(
      //     wallet: widget.wallet!,
      //     walletType: WalletType.hot,
      //   ),
      // );
    } else {
      // next mnemonic word
      setState(() {
        // set next seed phrase index
        _currentIndex += 1;

        // clear error text
        _errorText = null;

        // add confirmed index
        confirmedMnemonicIndex.add(index);

        // clear current word
        _currentWord = '';
      });
    }
  }

  bool validateMnemonicWord({
    required String mnemonicWord,
  }) {
    try {
      Logger.info('validateMnemonicWord params: mnemonicWord $mnemonicWord');

      final word = mnemonicWords[_currentIndex];

      final isValid = word == mnemonicWord;

      Logger.success('validateMnemonicWord isValid: $isValid');

      return isValid;
    } catch (_) {
      Logger.error('validateMnemonicWord isValid: isValid');

      return false;
    }
  }
}
