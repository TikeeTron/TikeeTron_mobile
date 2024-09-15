import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/button/button_rounded_ui.dart';
import '../../../../common/components/container/rounded_container.dart';
import '../../../../common/components/text/text_ui.dart';
import '../../../../common/config/padding_config.dart';
import 'seed_phrase_item_widget.dart';

class BackUpStepPageView extends StatefulWidget {
  final List<String> mnemonicWords;

  const BackUpStepPageView({
    super.key,
    required this.mnemonicWords,
  });

  @override
  State<BackUpStepPageView> createState() => _BackUpStepPageViewState();
}

class _BackUpStepPageViewState extends State<BackUpStepPageView> {
  bool isShowSeedPhrase = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Paddings.defaultPaddingH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIGap.h24,
          Text(
            'Your Seed Phrase',
            style: UITypographies.h4(context, fontSize: 28.sp),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Your seed phrase is your wallet’s key. Write it down and keep it safe for recovery.',
            style: UITypographies.bodyLarge(context, color: UIColors.grey500, fontSize: 15.sp),
          ),
          const SizedBox(
            height: 26,
          ),
          widget.mnemonicWords.isNotEmpty
              ? Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: widget.mnemonicWords.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SeedPhraseItemWidget(
                            text: '${index + 1}. ${widget.mnemonicWords[index]}',
                          );
                        },
                      ),
                    ),
                    if (!isShowSeedPhrase) ...[
                      Positioned.fill(
                        child: RoundedContainer(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF1F2025).withOpacity(0.9),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 4,
                              sigmaY: 4,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextUI(
                                  'Tap to reveal your seed phrase',
                                  overwriteStyle: context.theme.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextUI(
                                  'Make sure no one is watching your screen',
                                  overwriteStyle: context.theme.textTheme.labelSmall,
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                ButtonRoundedUI(
                                  text: 'View',
                                  useInkWell: true,
                                  useHeavyHaptic: true,
                                  color: context.theme.secondaryHeaderColor,
                                  prefixSvg: SvgConst.icEye,
                                  width: 169,
                                  onPress: () {
                                    setState(() {
                                      isShowSeedPhrase = !isShowSeedPhrase;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                )
              : Center(
                  child: SizedBox(
                    width: 100.w,
                    height: 100.w,
                    child: CupertinoActivityIndicator(
                      animating: true,
                      color: UIColors.white50,
                      radius: 10.w,
                    ),
                  ),
                ),
          const SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }
}
