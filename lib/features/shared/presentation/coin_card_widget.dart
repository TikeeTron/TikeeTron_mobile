import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/components/components.dart';
import '../../../../../common/themes/colors.dart';
import '../../../../../common/themes/typographies.dart';
import '../../../../../common/utils/extensions/theme_extension.dart';
import '../../home/domain/model/coin_model.dart';

class CoinCardWidget extends StatelessWidget {
  const CoinCardWidget({
    required this.onTap,
    required this.coin,
  });

  final void Function() onTap;
  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    return UIScaleButton(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        coin.name,
                        style: UITypographies.subtitleMedium(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      UIGap.h4,
                      Text(
                        '${coin.amount} ${coin.symbol}',
                        style: UITypographies.labelMedium(context).copyWith(
                          color: context.theme.colors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                UIGap.w8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${coin.change}%',
                        style: UITypographies.subtitleMedium(context).copyWith(
                          color: UIColors.green500,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      UIGap.h4,
                      Text(
                        '\$${coin.price}',
                        style: UITypographies.labelMedium(context).copyWith(
                          color: context.theme.colors.textSecondary,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
