import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../../common/components/button/bounce_tap.dart';
import '../../../../common/components/components.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../common/config/padding_config.dart';
import '../../../../common/constants/assets_const.dart';
import '../../../../common/themes/colors.dart';
import '../../../../common/themes/typographies.dart';

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
    return CupertinoPageScaffold(
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        title: '',
        trailing: BounceTap(
          onTap: () {},
          child: SvgUI(
            SvgConst.scanQr,
            color: UIColors.white50,
            width: 32.w,
            height: 32.w,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
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
                  onPressed: _seedPhraseController.text.isNotEmpty ? () {} : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
