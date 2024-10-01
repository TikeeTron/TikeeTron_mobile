import 'package:flutter/cupertino.dart';
import '../../common.dart';
import '../../config/padding_config.dart';
import '../button/button_rounded_ui.dart';
import '../cliprrect/smooth_cliprrect.dart';
import '../container/rounded_container.dart';
import '../image/asset_image_ui.dart';
import '../svg/svg_ui.dart';
import '../text/text_ui.dart';

class ConfirmationAlertWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? closeText;
  final String? confirmText;
  final String? imageName;
  final void Function()? onClose;
  final void Function()? onConfirm;
  final bool? useCloseButton;

  const ConfirmationAlertWidget(
      {super.key, this.title, this.description, this.closeText, this.confirmText, this.onClose, this.onConfirm, this.imageName, this.useCloseButton = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RoundedContainer(
          color: UIColors.black400,
          child: Padding(
            padding: Paddings.h24,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Stack(
                    children: [
                      const SvgUI(
                        SvgConst.icAlert,
                        height: 180,
                        disabledSetColor: true,
                      ),
                      Positioned(
                        left: -20,
                        bottom: 8,
                        top: 8,
                        child: SmoothClipRRect(
                          radius: 130,
                          child: SizedBox(
                            height: 150,
                            child: Opacity(
                              opacity: .1,
                              child: AssetImageUI(
                                path: imageName ?? IllustrationsConst.warning,
                                height: 300,
                                width: 300,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        top: 20,
                        right: 20,
                        child: Image.asset(imageName ?? IllustrationsConst.warning, height: 150, width: 150),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  if (title != null) ...[
                    TextUI(
                      title!,
                      fontSize: 24,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      weight: FontWeight.w600,
                      color: UIColors.white50,
                    ),
                  ],
                  const SizedBox(
                    height: 15,
                  ),
                  if (description != null) ...[
                    TextUI(
                      description!,
                      color: UIColors.white50,
                      maxLines: 4,
                      weight: FontWeight.w300,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      if (useCloseButton ?? true)
                        Expanded(
                          child: ButtonRoundedUI(
                            text: closeText ?? 'Close',
                            color: UIColors.primary500,
                            type: ButtonType.outline,
                            textColor: UIColors.white50,
                            onPress: () {
                              if (onClose != null) {
                                onClose!();
                              } else {
                                Navigator.of(context).pop(false);
                              }
                            },
                          ),
                        ),
                      if (useCloseButton ?? true)
                        const SizedBox(
                          width: 16,
                        ),
                      Expanded(
                        child: ButtonRoundedUI(
                          text: confirmText ?? 'Confirm',
                          onPress: () {
                            if (onConfirm != null) {
                              onConfirm!();
                            } else {
                              Navigator.of(context).pop(true);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
