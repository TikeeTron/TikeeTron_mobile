import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/components/components.dart';
import '../../../../common/constants/animation_const.dart';
import '../../../../common/constants/assets_const.dart';
import '../../../../common/themes/themes.dart';
import '../../core/routes/app_route.dart';

@RoutePage()
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _pageController = PageController();

  int _contentIndex = 0;

  Timer? _carouselTimer;

  @override
  void initState() {
    _carouselTimer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (_contentIndex < _OnBoardingContentEntity.contents.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: AnimationsConst.curveTransition,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: AnimationsConst.curveTransition,
          );
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          bottom: false,
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              _logoSection,
              Expanded(
                child: _contentSection,
              ),
              _actionSection,
              UIGap.h32,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _logoSection {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.h,
      ),
      child: SvgPicture.asset(
        IconsConst.logoFull,
        height: 45.h,
        width: 112.w,
      ),
    );
  }

  Widget get _contentSection {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: UIExpandablePageView.builder(
            controller: _pageController,
            itemCount: _OnBoardingContentEntity.contents.length,
            itemBuilder: (context, index) {
              final content = _OnBoardingContentEntity.contents[index];

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      content.illustration,
                      height: 256.r,
                      width: 256.r,
                    ),
                    UIGap.size(h: 52.h),
                    Text(
                      content.title,
                      style: UITypographies.h4(context),
                    ),
                    UIGap.h8,
                    Text(
                      content.description + '\n\n',
                      style: UITypographies.bodyMedium(context),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ],
                ),
              );
            },
            onPageChanged: (value) {
              if (_contentIndex != value) {
                setState(() {
                  _contentIndex = value;
                });
              }
            },
          ),
        ),
        UIGap.h24,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [0, 1, 2].map((index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: AnimationsConst.curveTransition,
              margin: EdgeInsets.only(
                right: index != 2 ? 4.w : 0,
              ),
              width: _contentIndex == index ? 28.r : 8.r,
              height: 8.r,
              decoration: BoxDecoration(
                color: _contentIndex == index ? UIColors.black50 : UIColors.black400,
                borderRadius: BorderRadius.circular(8).r,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget get _actionSection {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UIPrimaryButton(
            onPressed: () => navigationService.pushAndPopUntil(
              const CreateWalletRoute(),
              predicate: (p0) => false,
            ),
            text: 'Create Wallet',
            size: UIButtonSize.large,
          ),
          UIGap.h12,
          const UITertiaryButton(
            // onPressed: () => navigationService.push(const RegisterRoute()),
            text: 'Import Wallet',
            size: UIButtonSize.large,
          ),
        ],
      ),
    );
  }
}

class _OnBoardingContentEntity {
  final String title;
  final String description;
  final String illustration;

  const _OnBoardingContentEntity({
    required this.title,
    required this.description,
    required this.illustration,
  });

  static const List<_OnBoardingContentEntity> contents = [
    _OnBoardingContentEntity(
      title: 'Manage Your Assets',
      description: 'Effortlessly track and manage your crypto assets with our intuitive dashboard.',
      illustration: IllustrationsConst.onBoarding1,
    ),
    _OnBoardingContentEntity(
      title: 'Connect with Wallets',
      description: 'Link your wallet with this Xollet for seamless transfers.',
      illustration: IllustrationsConst.onBoarding2,
    ),
    _OnBoardingContentEntity(
      title: 'Transfer Assets',
      description: 'Send and receive crypto quickly. Just scan the QR code or enter the wallet address.',
      illustration: IllustrationsConst.onBoarding3,
    ),
  ];
}
