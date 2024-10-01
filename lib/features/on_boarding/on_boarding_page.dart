import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/components/components.dart';
import '../../../../common/constants/animation_const.dart';
import '../../../../common/constants/assets_const.dart';
import '../../../../common/themes/themes.dart';
import '../../common/utils/helpers/modal_helper.dart';
import '../../core/routes/app_route.dart';
import 'widgets/auth_type_modal.dart';

@RoutePage()
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _pageController = PageController();

  int _contentIndex = 0;

  @override
  void initState() {
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
      resizeToAvoidBottomInset: true,
      backgroundColor: UIColors.black500,
      child: _contentSection,
    );
  }

  Widget get _contentSection {
    return Stack(
      children: [
        UIExpandablePageView.builder(
          controller: _pageController,
          itemCount: _OnBoardingContentEntity.contents.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final content = _OnBoardingContentEntity.contents[index];
            return Image.asset(
              content.illustration,
              fit: BoxFit.cover,
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
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: <Widget>[
                  Text(
                    _OnBoardingContentEntity.contents[_contentIndex].title,
                    textAlign: TextAlign.center,
                    style: UITypographies.h3(
                      context,
                      fontSize: 34.sp,
                    ),
                  ),
                  UIGap.h12,
                  Text(
                    _OnBoardingContentEntity.contents[_contentIndex].description + '\n\n',
                    style: UITypographies.bodyMedium(
                      context,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            UIGap.size(h: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: UIColors.grey700.withOpacity(0.55),
                borderRadius: BorderRadius.circular(16).r,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [0, 1, 2].map((index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: AnimationsConst.curveTransition,
                    margin: EdgeInsets.only(
                      right: index != 2 ? 8.w : 0,
                    ),
                    width: 8.r,
                    height: 8.r,
                    decoration: BoxDecoration(
                      color: _contentIndex == index ? UIColors.black50 : UIColors.grey600,
                      borderRadius: BorderRadius.circular(8).r,
                    ),
                  );
                }).toList(),
              ),
            ),
            UIGap.size(h: 12.h),
            _actionSection,
            UIGap.size(h: 32.h),
          ],
        ),
      ],
    );
  }

  Widget get _actionSection {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: SizedBox(
        width: double.infinity,
        child: UIPrimaryButton(
          onPressed: () async {
            if (_contentIndex != 2) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: AnimationsConst.curveTransition,
              );
            } else {
              await ModalHelper.showModalBottomSheet(
                context,
                child: AuthTypeModal(
                  onCreateWallet: () {
                    navigationService.push(
                      const CreateWalletRoute(),
                    );
                  },
                  onImportWallet: () {
                    navigationService.push(
                      const ImportWalletRoute(),
                    );
                  },
                ),
                isHasCloseButton: false,
                padding: EdgeInsets.zero,
              );
            }
          },
          text: _contentIndex == 2 ? 'Get Started' : 'Next',
          size: UIButtonSize.large,
        ),
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
      title: 'Your Digital\nTicketing Solution',
      description: 'Discover exclusive events with secure,\nblockchain-powered tickets.',
      illustration: IllustrationsConst.onBoarding1,
    ),
    _OnBoardingContentEntity(
      title: 'Buy, Sell, and\nTransfer Tickets',
      description: 'Seamlessly manage your tickets from your\nwallet. Trade and transfer with ease.',
      illustration: IllustrationsConst.onBoarding2,
    ),
    _OnBoardingContentEntity(
      title: 'Join the Future\nof Ticketing',
      description: 'Your events, your way. Secure,\ntransparent, and ready for you.',
      illustration: IllustrationsConst.onBoarding3,
    ),
  ];
}
