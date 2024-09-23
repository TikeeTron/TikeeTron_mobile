import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/common.dart';
import '../../../../../common/components/button/bounce_tap.dart';
import '../../../../../common/components/container/grabber_container.dart';
import 'filter_type_widget.dart';

class FilterEventModal extends StatefulWidget {
  final void Function()? onResetFilter;
  final void Function()? onApplyFilter;
  final void Function(String value)? onSelectedEventType;
  final void Function(String value)? onSelectedEventDate;
  final void Function(String value)? onSelectedEventTime;
  final List<String> listEventType;
  final List<String> listEventDate;
  final List<String> listEventTime;
  const FilterEventModal({
    super.key,
    this.onResetFilter,
    this.onApplyFilter,
    required this.listEventType,
    required this.listEventDate,
    required this.listEventTime,
    this.onSelectedEventType,
    this.onSelectedEventDate,
    this.onSelectedEventTime,
  });

  @override
  State<FilterEventModal> createState() => _FilterEventModalState();
}

class _FilterEventModalState extends State<FilterEventModal> {
  List<String> _selectedEventType = [];
  List<String> _selectedEventDate = [];
  List<String> _selectedEventTime = [];
  void _onEventTypeSelection(String value) {
    setState(() {
      if (_selectedEventType.contains(value)) {
        _selectedEventType.remove(value);
      } else {
        _selectedEventType.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: UIColors.black400,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: const GrabberContainer(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 37.h, left: 16.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Options',
                  textAlign: TextAlign.center,
                  style: UITypographies.h4(
                    context,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: UIColors.primary500.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Text(
                    'Reset Filter',
                    style: UITypographies.bodyLarge(
                      context,
                      color: UIColors.primary500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          UIGap.h20,
          UIDivider(
            color: UIColors.white50.withOpacity(0.15),
            thickness: 1.r,
          ),
          UIGap.h20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Event Type',
                  textAlign: TextAlign.start,
                  style: UITypographies.subtitleLarge(
                    context,
                    fontSize: 17.sp,
                  ),
                ),
                UIGap.h12,
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(
                    widget.listEventType.length,
                    (index) => BounceTap(
                      onTap: () => _onEventTypeSelection(widget.listEventType[index]),
                      child: FilterTypeWidget(
                        isSelected: _selectedEventType.contains(widget.listEventType[index]),
                        value: widget.listEventType[index],
                      ),
                    ),
                  ),
                ),
                UIGap.h20,
                Text(
                  'Date',
                  textAlign: TextAlign.start,
                  style: UITypographies.subtitleLarge(
                    context,
                    fontSize: 17.sp,
                  ),
                ),
                UIGap.h12,
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(
                    widget.listEventDate.length,
                    (index) => BounceTap(
                      onTap: () => _onEventTypeSelection(widget.listEventType[index]),
                      child: FilterTypeWidget(
                        isSelected: _selectedEventType.contains(widget.listEventType[index]),
                        value: widget.listEventDate[index],
                      ),
                    ),
                  ),
                ),
                UIGap.h20,
                Text(
                  'Date',
                  textAlign: TextAlign.start,
                  style: UITypographies.subtitleLarge(
                    context,
                    fontSize: 17.sp,
                  ),
                ),
                UIGap.h12,
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(
                    widget.listEventTime.length,
                    (index) => BounceTap(
                      onTap: () => _onEventTypeSelection(widget.listEventType[index]),
                      child: FilterTypeWidget(
                        isSelected: _selectedEventType.contains(widget.listEventType[index]),
                        value: widget.listEventTime[index],
                      ),
                    ),
                  ),
                ),
                UIGap.h40,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: UIPrimaryButton(
                    text: 'Apply Filter',
                    size: UIButtonSize.large,
                    onPressed: () {
                      context.maybePop();
                    },
                  ),
                ),
                UIGap.h20,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
