import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatHelper {
  static TextInputFormatter digitsOnly = FilteringTextInputFormatter.digitsOnly;

  static TextInputFormatter noWhitespace =
      FilteringTextInputFormatter.deny(RegExp(r'\s'));

  static MaskTextInputFormatter maskPhone() => MaskTextInputFormatter(
        mask: '+65 ###-####-#####',
        filter: {
          "#": RegExp(r'[0-9]'),
        },
        type: MaskAutoCompletionType.lazy,
      );
}
