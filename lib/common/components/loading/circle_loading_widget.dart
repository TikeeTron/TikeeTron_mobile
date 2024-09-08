import 'package:flutter/cupertino.dart';
import '../../utils/extensions/theme_extension.dart';

class CircleLoadingWidget extends StatelessWidget {
  const CircleLoadingWidget({
    this.color,
    this.waveSize,
    this.boxSize,
    Key? key,
  }) : super(key: key);

  final Color? color;
  final double? waveSize;
  final double? boxSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxSize ?? 19,
      height: boxSize ?? 19,
      child: CupertinoActivityIndicator(
        color: context.theme.dividerColor,
        radius: waveSize ?? 10,
      ),
    );
  }
}
