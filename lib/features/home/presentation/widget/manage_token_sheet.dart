import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/components/components.dart';
import '../../../../common/constants/assets_const.dart';
import '../../../../common/themes/typographies.dart';
import '../../domain/model/coin_model.dart';

class ManageTokenBottomSheet extends StatelessWidget {
  const ManageTokenBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: UITextField(
            hint: 'Search token',
            suffixIcon: SvgPicture.asset(
              IconsConst.search,
              width: 20.r,
              height: 20.r,
            ),
          ),
        ),
        UIGap.h20,
        Expanded(
          child: ListView.separated(
            physics: const BottomBouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final coin = dummyCoinsMore[index];

              return UIScaleButton(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            coin.imageUrl,
                            width: 32.r,
                            height: 32.r,
                          ),
                          UIGap.w8,
                          Expanded(
                            child: Text(
                              coin.name,
                              style: UITypographies.subtitleMedium(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          UIGap.w8,
                          SizedBox(
                            height: 20.h,
                            width: 34.w,
                            child: Transform.scale(
                              scale: .7,
                              child: CupertinoSwitch(
                                value: index == 0,
                                applyTheme: true,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const UIDivider(),
            itemCount: dummyCoinsMore.length,
          ),
        ),
        UIGap.h20,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: UIPrimaryButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'Save',
            size: UIButtonSize.large,
          ),
        ),
        UIGap.h20,
      ],
    );
  }
}
