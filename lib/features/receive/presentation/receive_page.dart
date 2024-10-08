import 'package:auto_route/auto_route.dart';
import 'package:blockies/blockies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter_new/qr_flutter.dart';
import '../../../common/common.dart';
import '../../../common/components/app_bar/scaffold_app_bar.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/container/rounded_container.dart';
import '../../../common/config/padding_config.dart';
import '../../../common/utils/extensions/dynamic_parsing.dart';
import '../../wallet/presentation/cubit/active_wallet/active_wallet_cubit.dart';

@RoutePage()
class ReceivePage extends StatefulWidget {
  final String walletAddress;
  const ReceivePage({super.key, required this.walletAddress});

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  bool _isCopy = false;

  void _toggleCopy() async {
    setState(() {
      _isCopy = !_isCopy;
    });

    Clipboard.setData(ClipboardData(text: widget.walletAddress)).then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isCopy = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: UIColors.black500,
      navigationBar: ScaffoldAppBar.cupertino(
        context,
        middle: Text(
          'Receive',
          style: UITypographies.h4(
            context,
            color: UIColors.white50,
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
      child: BlocBuilder<ActiveWalletCubit, ActiveWalletState>(
        builder: (context, state) {
          return SafeArea(
            bottom: false,
            child: Padding(
              padding: Paddings.defaultPaddingH,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    UIGap.size(h: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: UIColors.white50.withOpacity(0.15),
                            ),
                            borderRadius: BorderRadius.circular(99.r),
                          ),
                          child: Row(
                            children: <Widget>[
                              RoundedContainer(
                                width: 28.w,
                                height: 28.w,
                                radius: 9999,
                                child: Blockies(
                                  seed: widget.walletAddress,
                                ),
                              ),
                              UIGap.w12,
                              Text(
                                shortedAddress,
                                style: UITypographies.bodyLarge(
                                  context,
                                ),
                              ),
                              UIGap.w12,
                              Icon(
                                CupertinoIcons.chevron_down,
                                color: UIColors.white50,
                                size: 16.w,
                              ),
                              UIGap.w4,
                            ],
                          ),
                        ),
                      ],
                    ),
                    UIGap.size(h: 40.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 36.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: UIColors.black400,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'Scan this code or share your wallet address to receive TRX.',
                        textAlign: TextAlign.center,
                        style: UITypographies.bodyLarge(
                          context,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                    UIGap.size(h: 20.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.r),
                      child: QrImageView(
                        data: widget.walletAddress,
                        version: QrVersions.auto,
                        size: 270.h,
                        gapless: true,
                        embeddedImage: const AssetImage(ImagesConst.appLogoRounded),
                        padding: EdgeInsets.all(30.w),
                        backgroundColor: UIColors.white50,
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(60.w, 60.w),
                          borderRadius: 20.r,
                          safeArea: true,
                          safeAreaMultiplier: 1,
                          embeddedImageShape: EmbeddedImageShape.circle,
                        ),
                        eyeStyle: const QrEyeStyle(
                          color: UIColors.black500,
                          eyeShape: QrEyeShape.square,
                          borderRadius: 0,
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          borderRadius: 0,
                          roundedOutsideCorners: true,
                          color: UIColors.black500,
                          dataModuleShape: QrDataModuleShape.square,
                        ),
                        errorStateBuilder: (cxt, err) {
                          return const Center(
                            child: Text(
                              "Uh oh! Something went wrong...",
                            ),
                          );
                        },
                      ),
                    ),
                    UIGap.size(h: 20.h),
                    BounceTap(
                      onTap: _toggleCopy,
                      useInkWell: true,
                      useHeavyHaptic: true,
                      useSplash: true,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        margin: EdgeInsets.symmetric(horizontal: 40.w),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: _isCopy ? UIColors.primary500.withOpacity(0.15) : UIColors.black400,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _isCopy ? "Copied!" : shortedAddress,
                              style: UITypographies.bodyLarge(
                                context,
                                fontSize: 17.sp,
                                color: _isCopy ? UIColors.blue500 : UIColors.white50,
                              ),
                            ),
                            UIGap.w8,
                            Icon(
                              _isCopy ? Icons.check : Icons.copy,
                              size: 16.w,
                              color: _isCopy ? UIColors.blue500 : UIColors.white50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String get shortedAddress {
    if (widget.walletAddress.isNotEmpty) {
      return DynamicParsing(widget.walletAddress).shortedWalletAddress!;
    }
    return '';
  }
}
