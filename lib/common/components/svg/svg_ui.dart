import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common.dart';

enum SvgSource {
  asset,
  network,
}

class SvgUI extends StatelessWidget {
  const SvgUI(
    this.path, {
    Key? key,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    this.color,
    this.disabledSetColor,
    this.fit,
    this.size,
    this.source,
  }) : super(key: key);

  final String? path;
  final Function()? onTap;
  final double? width;
  final double? height;
  final double? size;
  final EdgeInsets? padding;
  final Color? color;
  final bool? disabledSetColor;
  final SvgSource? source;

  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (onTap != null) {
      return GestureDetector(onTap: onTap ?? () {}, child: buildView(context));
    }

    return buildView(context);
  }

  Widget buildView(BuildContext context) {
    if (path == '') {
      return const SizedBox.shrink();
    }

    if (source == SvgSource.network) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SvgPicture.network(
          path!,
          width: size ?? (width ?? 24),
          height: size ?? (height ?? 24),
          // ignore: deprecated_member_use
          color: getColor(context),
          fit: fit ?? BoxFit.fitWidth,
          placeholderBuilder: (context) {
            return Icon(
              Icons.broken_image,
              color: context.theme.colors.primary,
            );
          },
        ),
      );
    }

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SvgPicture.asset(
        path!,
        width: size ?? (width ?? 24),
        height: size ?? (height ?? 24),
        // ignore: deprecated_member_use
        color: getColor(context),
        fit: fit ?? BoxFit.fitWidth,
        placeholderBuilder: (context) {
          return Icon(
            Icons.broken_image,
            color: context.theme.colors.primary,
            size: size ?? (width ?? 24),
          );
        },
      ),
    );
  }

  Color? getColor(BuildContext context) {
    if (disabledSetColor == true) {
      return null;
    }

    return color ?? context.theme.colors.primary;
  }
}
