import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/text/text_ui.dart';
import '../../../../common/config/padding_config.dart';
import '../../../../common/utils/extensions/list_string_parsing.dart';
import '../../../../common/utils/helpers/logger_helper.dart';
import '../../../../core/core.dart';
import '../../data/model/wallet_model.dart';
import '../success_create_wallet_page.dart';
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
  Map<String, int> originalIndices = {};
  int _currentIndex = 0;
  String _currentWord = '';

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    mnemonicWords = widget.mnemonicWords;
    for (int i = 0; i < mnemonicWords.length; i++) {
      originalIndices[mnemonicWords[i]] = i;
    }
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
            Text(
              'Verify Your Seed Phrase',
              style: UITypographies.h4(context, fontSize: 28.sp),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Select each word in the order as presented to you previously',
              style: UITypographies.bodyLarge(
                context,
                color: UIColors.grey500,
                fontSize: 15.sp,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            if (mnemonicWords.isContainSameElement) ...[
              const SizedBox(
                height: 8,
              ),
              Text(
                'You might see the same words appeared within the seed phrase generated',
                style: UITypographies.bodyLarge(
                  context,
                  color: UIColors.grey500,
                  fontSize: 15.sp,
                ),
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
                    index: originalIndices[word],
                    isConfirmed: isConfirmed,
                    textAlignment: CrossAxisAlignment.center,
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
        _currentWord = '';
      });
      toastHelper.showError('The seed phrase you entered is incorrect. Please try again.');
      return;
    }

    // next step
    if ((_currentIndex + 1) == mnemonicWords.length) {
      // go to success create wallet page
      navigationService.pushAndPopUntil(
        SuccessCreateWalletRoute(
          params: SuccessCreateWalletPageParams(
            wallet: widget.wallet!,
          ),
        ),
        predicate: (route) => false,
      );
    } else {
      // next mnemonic word
      setState(() {
        // set next seed phrase index
        _currentIndex += 1;

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
