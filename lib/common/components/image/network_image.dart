import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/assets_const.dart';
import '../../themes/colors.dart';
import '../indicator/loading_indicator.dart';

class UINetworkImage extends StatelessWidget {
  const UINetworkImage({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.backgroundColor,
    this.colorFilter,
  });

  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8).r,
        decoration: BoxDecoration(
          color: UIColors.black300,
          borderRadius: borderRadius,
        ),
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: (height ?? 64.r) * .5,
            maxWidth: (width ?? 64.r) * .5,
          ),
          child: Image.asset(
            ImagesConst.placeholderPhoto,
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      return CachedNetworkImage(
        fit: fit,
        width: width,
        height: height,
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              colorFilter: colorFilter,
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        useOldImageOnUrlChange: true,
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          padding: const EdgeInsets.all(8).r,
          decoration: BoxDecoration(
            color: UIColors.black300,
            borderRadius: borderRadius,
          ),
          alignment: Alignment.center,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 36.r,
              maxWidth: 36.r,
            ),
            child: const UILoadingIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          padding: const EdgeInsets.all(8).r,
          decoration: BoxDecoration(
            color: UIColors.black300,
            borderRadius: borderRadius,
          ),
          alignment: Alignment.center,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: (height ?? 64.r) * .5,
              maxWidth: (width ?? 64.r) * .5,
            ),
            child: Image.asset(
              ImagesConst.placeholderPhoto,
              fit: BoxFit.contain,
            ),
          ),
        ),
        cacheManager: CacheManager(
          Config(
            'image',
            maxNrOfCacheObjects: 20,
            stalePeriod: const Duration(days: 7),
          ),
        ),
      );
    }
  }
}
