import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/components.dart';
import 'modal_helper.dart';

class DateHelper {
  static void showDatePicker(
    BuildContext context, {
    String? title,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required void Function(DateTime) onDateSelected,
  }) {
    DateTime? _selectedDate = initialDate;

    ModalHelper.showModalBottomSheet(
      context,
      padding: EdgeInsets.zero,
      title: title ?? 'Select Date',
      child: StatefulBuilder(builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 160.h,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                itemExtent: 36.h,
                initialDateTime: initialDate,
                minimumDate: firstDate,
                maximumDate: lastDate,
                onDateTimeChanged: (dateTime) {
                  _selectedDate = dateTime;
                },
              ),
            ),
            UIGap.h24,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: UISecondaryButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  UIGap.w16,
                  Expanded(
                    child: UIPrimaryButton(
                      text: 'Done',
                      onPressed: () {
                        if (_selectedDate != null) {
                          onDateSelected(_selectedDate!);
                        }

                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
            UIGap.h20,
          ],
        );
      }),
    );
  }
}
