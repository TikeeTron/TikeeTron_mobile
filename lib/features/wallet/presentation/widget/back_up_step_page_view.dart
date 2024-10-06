import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/container/rounded_container.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../common/config/padding_config.dart';
import '../../../../common/utils/extensions/list_string_parsing.dart';
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
                          color: UIColors.black500.withOpacity(0.4),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 4,
                              sigmaY: 4,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tap to reveal your seed phrase',
                                  style: UITypographies.subtitleLarge(context),
                                ),
                                UIGap.h12,
                                Text(
                                  'Write down your seed phrase and keep it secure.',
                                  style: UITypographies.bodyMedium(context, color: UIColors.grey500),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                BounceTap(
                                  onTap: () {
                                    setState(() {
                                      isShowSeedPhrase = !isShowSeedPhrase;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        CupertinoIcons.eye,
                                        color: UIColors.primary500,
                                        size: 24.w,
                                      ),
                                      UIGap.w4,
                                      Text(
                                        'View',
                                        style: UITypographies.bodyLarge(context, color: UIColors.primary500),
                                      ),
                                    ],
                                  ),
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
          if (widget.mnemonicWords.isContainSameElement && widget.mnemonicWords.isNotEmpty && isShowSeedPhrase) ...[
            SizedBox(
              height: 8.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: UIColors.black400,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'You might see the same words appeared within the seed phrase generated',
                style: UITypographies.bodyLarge(
                  context,
                  color: UIColors.white50,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          UIGap.h20,
          BounceTap(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: widget.mnemonicWords.join(' '))).then((_) {
                toastHelper.showSuccess('Copied!');
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgUI(
                  IconsConst.copyFill,
                  size: 22.w,
                  color: UIColors.primary500,
                ),
                UIGap.w4,
                Text(
                  'Copy to clipboard',
                  style: UITypographies.bodyLarge(
                    context,
                    color: UIColors.primary500,
                  ),
                ),
              ],
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
