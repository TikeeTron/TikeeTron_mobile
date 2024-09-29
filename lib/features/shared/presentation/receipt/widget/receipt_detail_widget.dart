import 'package:flutter/cupertino.dart';

import '../../../../../common/common.dart';

class ReceiptDetailWidget extends StatelessWidget {
  final String title;
  final String value;
  const ReceiptDetailWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: UITypographies.bodyLarge(
            context,
            color: UIColors.grey500,
          ),
        ),
        Text(
          value,
          style: UITypographies.subtitleLarge(context),
        ),
      ],
    );
  }
}
