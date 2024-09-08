import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../text/text_ui.dart';
import '../../utils/extensions/size_extension.dart';
import '../../utils/extensions/theme_extension.dart';
import '../button/bounce_tap.dart';

enum ScaffoldTitleAlignment { left, right, center }

class ScaffoldAppBar {
  static CupertinoNavigationBar cupertino(
    BuildContext context, {
    String? title,
    Widget? trailing,
    Widget? leading,
    ScaffoldTitleAlignment titleAlignment = ScaffoldTitleAlignment.left,
  }) {
    return CupertinoNavigationBar(
      backgroundColor: Colors.transparent,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 24,
      ),
      automaticallyImplyLeading: false,
      leading: _LeadingWidget(leading: leading),
      middle: (title != null)
          ? Row(
              mainAxisAlignment: titleAlignment == ScaffoldTitleAlignment.left
                  ? MainAxisAlignment.start
                  : titleAlignment == ScaffoldTitleAlignment.right
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.center,
              children: [
                BounceTap(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextUI(
                      title,
                      color: context.theme.primaryColorDark,
                      fontSize: 20,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          : null,
      trailing: trailing,
    );
  }

  static CupertinoSliverNavigationBar cupertinoSliver(
    BuildContext context, {
    String? title,
    Widget? trailing,
    Widget? leading,
    ScaffoldTitleAlignment titleAlignment = ScaffoldTitleAlignment.left,
  }) {
    return CupertinoSliverNavigationBar(
      largeTitle: const Text(''),
      // backgroundColor: Colors.transparent,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 24,
      ),
      automaticallyImplyLeading: false,
      leading: _LeadingWidget(leading: leading),
      middle: (title != null)
          ? Row(
              mainAxisAlignment: titleAlignment == ScaffoldTitleAlignment.left
                  ? MainAxisAlignment.start
                  : titleAlignment == ScaffoldTitleAlignment.right
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.center,
              children: [
                BounceTap(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextUI(
                      title,
                      color: context.theme.primaryColorDark,
                      fontSize: 20,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          : null,
      trailing: trailing,
    );
  }
}

class _LeadingWidget extends StatelessWidget {
  final Widget? leading;

  const _LeadingWidget({
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    if (leading != null) {
      return leading!;
    }

    if (context.isFirstRoute == false) {
      return BounceTap(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          color: context.theme.primaryColorDark,
          size: 18,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
