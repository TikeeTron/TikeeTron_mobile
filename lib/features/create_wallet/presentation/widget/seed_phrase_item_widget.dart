import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/components/container/rounded_container.dart';
import '../../../../common/components/text/auto_size_text_widget.dart';
import '../../../../core/utils/extension/theme_extension.dart';

class SeedPhraseItemWidget extends StatelessWidget {
  final String text;
  final bool? isConfirmed;
  final Function()? onTap;

  const SeedPhraseItemWidget({
    super.key,
    required this.text,
    this.isConfirmed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: RoundedContainer(
        borderRadius: BorderRadius.circular(10),
        padding: const EdgeInsets.all(12),
        border: Border.all(
          color: const Color(0xFF34373E),
        ),
        useBorder: true,
        color: (isConfirmed == true) ? const Color(0xFF1F2025).withOpacity(0.3) : const Color(0xFF1F2025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeTextWidget(
              text,
              color: (isConfirmed == true) ? context.theme.hintColor.withOpacity(0.3) : context.theme.primaryColor,
              fontSize: 14,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
