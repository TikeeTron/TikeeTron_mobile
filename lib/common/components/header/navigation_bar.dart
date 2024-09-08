import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/typographies.dart';
import '../../utils/extensions/theme_extension.dart';
import '../button/fade_button.dart';

class UINavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const UINavigationBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.trailing,
  });

  final String title;
  final void Function()? onBackPressed;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      backgroundColor: Colors.transparent.withOpacity(0),
      middle: Text(
        title,
        style: UITypographies.h6(context),
      ),
      leading: onBackPressed == null
          ? null
          : UIFadeButton(
              onTap: onBackPressed,
              child: SizedBox(
                width: 20.r,
                height: 20.r,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16.r,
                  color: context.theme.colors.textPrimary,
                ),
              ),
            ),
      trailing: trailing,
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => false;

  @override
  Size get preferredSize =>
      const Size.fromHeight(kMinInteractiveDimensionCupertino);
}
