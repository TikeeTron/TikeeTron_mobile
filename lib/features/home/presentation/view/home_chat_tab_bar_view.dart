import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common.dart';
import '../../../../common/components/svg/svg_ui.dart';
import '../../../../common/config/padding_config.dart';
import '../widget/home_chat_menu_widget.dart';

class HomeChatTabBarView extends StatefulWidget {
  const HomeChatTabBarView({super.key});

  @override
  State<HomeChatTabBarView> createState() => _HomeChatTabBarViewState();
}

class _HomeChatTabBarViewState extends State<HomeChatTabBarView> {
  TextEditingController _chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: Paddings.defaultPaddingH,
              child: Column(
                children: <Widget>[
                  UIGap.size(h: 100.h),
                  SvgUI(
                    SvgConst.icAiHome,
                    width: 54.w,
                    height: 54.h,
                  ),
                  UIGap.size(h: 30.h),
                  Text(
                    'Welcome, Dani',
                    style: UITypographies.h2(
                      context,
                      fontSize: 28.sp,
                    ),
                  ),
                  UIGap.size(h: 4.h),
                  Text(
                    'Ask anything about events, tickets, or more.',
                    style: UITypographies.bodyLarge(
                      context,
                      color: UIColors.grey500,
                    ),
                  ),
                  UIGap.size(h: 40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      children: <Widget>[
                        const HomeChatMenuWidget(
                          icon: IconsConst.icConcertHome,
                          title: 'Find concerts',
                          subtitle: 'near me this weekend.',
                        ),
                        UIGap.h12,
                        const HomeChatMenuWidget(
                          icon: IconsConst.icFestivalHome,
                          title: 'Explore top festivals',
                          subtitle: 'this month.',
                        ),
                        UIGap.h12,
                        const HomeChatMenuWidget(
                          icon: IconsConst.icTicketHome,
                          title: 'Check tickets',
                          subtitle: 'for sports events.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: _ChatTextFieldWidget(controller: _chatController),
          ),
        ],
      ),
    );
  }
}

class _ChatTextFieldWidget extends StatelessWidget {
  const _ChatTextFieldWidget({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 96.h,
      color: UIColors.black500,
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 30.h,
        left: 16.w,
        right: 16.w,
      ),
      child: UITextField(
        textController: controller,
        radius: 99.r,
        hint: 'Chat with Tibot...',
        suffixIcon: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: UIColors.primary500,
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Icon(Icons.mic),
        ),
        hintColor: UIColors.white50.withOpacity(0.4),
        fillColor: UIColors.black400,
        borderColor: UIColors.white50.withOpacity(0.15),
      ),
    );
  }
}
