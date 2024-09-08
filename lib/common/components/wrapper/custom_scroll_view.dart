import 'package:flutter/widgets.dart';

import '../../utils/helpers/focus_helper.dart';

class UICustomScrollView extends StatelessWidget {
  const UICustomScrollView({
    super.key,
    required this.slivers,
    this.onTap,
    this.scrollController,
    this.physics = const BouncingScrollPhysics(),
  });

  final List<Widget> slivers;
  final Function? onTap;
  final ScrollController? scrollController;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusHelper.unfocus();
        onTap?.call();
      },
      child: CustomScrollView(
        controller: scrollController,
        physics: physics,
        slivers: slivers,
      ),
    );
  }
}
