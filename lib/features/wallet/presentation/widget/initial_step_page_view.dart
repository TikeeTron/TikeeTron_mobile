import 'package:flutter/cupertino.dart';
import '../../../../common/common.dart';
import '../../../../common/utils/extensions/size_extension.dart';
import '../../../../common/config/font_config.dart';
import '../../../../common/components/text/text_ui.dart';

class InitialStepPageView extends StatelessWidget {
  const InitialStepPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 46,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Spacer(),
          Image.asset(
            ImagesConst.coinBnb,
            height: MediaQuery.of(context).size.width * .75,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          const SizedBox(
            height: 20,
          ),
          TextUI(
            'Seed Phrase',
            textAlign: TextAlign.center,
            color: context.theme.colors.primary,
            weight: FontWeight.w600,
            fontSize: 24,
          ),
          const SizedBox(
            height: 16,
          ),
          TextUI(
            'Protect your wallet by storing your secret recovery phrase in a safe place. This is the only way to restore your wallet if the app is locked or you have a new device',
            textAlign: TextAlign.center,
            color: context.theme.colors.primary,
            fontFamily: FontFamily.dmSans.name,
            fontSize: 16,
            maxLines: 4,
          ),
          SizedBox(
            height: (context.height ?? 0) * 0.15,
          ),
        ],
      ),
    );
  }
}
