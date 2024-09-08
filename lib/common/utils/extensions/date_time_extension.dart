import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension XDateTime on DateTime {
  String timeAgoFormat({
    bool isWithDay = true,
    bool isWithDayName = false,
    bool isWithMonth = true,
    bool isCompactMonth = true,
    bool isWithYear = true,
  }) {
    final diff = DateTime.now().difference(this);

    if (diff.inDays > 0) {
      return dateTextFormat(
        isWithDay: isWithDay,
        isWithDayName: isWithDayName,
        isWithMonth: isWithMonth,
        isCompactMonth: isCompactMonth,
        isWithYear: isWithYear,
      );
    } else {
      return timeago.format(this);
    }
  }

  String dateTimeFormat({
    bool isWithDay = true,
    bool isWithDayName = false,
    bool isWithMonth = true,
    bool isCompactMonth = true,
    bool isWithYear = true,
    bool isWithSecond = false,
    bool isWithTimeZone = false,
  }) {
    return '${dateTextFormat(
      isWithDay: isWithDay,
      isWithDayName: isWithDayName,
      isWithMonth: isWithMonth,
      isCompactMonth: isCompactMonth,
      isWithYear: isWithYear,
    )}, ${timeTextFormat(
      isWithSecond: isWithSecond,
      isWithTimeZone: isWithTimeZone,
    )}';
  }

  String dateNumberFormat({
    bool isYearFirst = false,
    String separator = '/',
    bool isCompactYear = false,
  }) {
    String yearFormat = isCompactYear ? 'yy' : 'yyyy';

    return DateFormat(
      "${isYearFirst ? yearFormat : 'dd'}${separator}MM${separator}${isYearFirst ? 'dd' : yearFormat}",
      'id',
    ).format(this);
  }

  String dateTextFormat({
    bool isWithDay = true,
    bool isWithDayName = false,
    bool isWithMonth = true,
    bool isCompactMonth = false,
    bool isWithYear = true,
  }) {
    return DateFormat(
      "${isWithDayName ? 'EEEE, ' : ''}${isWithDay ? 'dd ' : ''}"
          "${isWithMonth ? isCompactMonth ? 'MMM' : 'MMMM' : ''}"
          "${isWithYear ? ' yyyy' : ''}",
      'id',
    ).format(this);
  }

  String timeTextFormat({
    bool isWithSecond = false,
    bool isWithTimeZone = false,
  }) {
    return DateFormat(
      "HH:mm${isWithSecond ? ':ss' : ''}${isWithTimeZone ? ' ${this.timeZoneName}' : ''}",
      'id',
    ).format(this);
  }

  String countdownFormat({
    bool isWithName = false,
  }) {
    final now = dateOnly();
    final diff = now.difference(this);

    return diff.durationTextFormat(isWithName: isWithName);
  }

  String rangeFormat(DateTime? toDate) {
    final isSameYear = year == toDate?.year;
    final isSameMonth = isSameYear && month == toDate?.month;
    final isSameDay = isSameMonth && day == toDate?.day;

    final date1TextFormat = !isSameDay
        ? dateTextFormat(
            isWithMonth: !isSameMonth || !isSameYear,
            isCompactMonth: true,
            isWithYear: !isSameYear,
          )
        : null;
    final date2TextFormat =
        toDate != null ? toDate.dateTextFormat(isCompactMonth: true) : null;

    return '${date1TextFormat ?? ''}'
        '${!isSameDay ? ' - ' : ''}'
        '${date2TextFormat ?? ''}';
  }

  DateTime dateOnly({
    bool isWithMonth = true,
    bool isWithDay = true,
  }) {
    return DateTime(
      year,
      isWithMonth ? month : 1,
      isWithDay ? day : 1,
    );
  }

  DateTime get timeOnly {
    return DateTime(
      0,
      0,
      0,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  Duration get timeDuration {
    return Duration(
      hours: hour,
      minutes: minute,
      seconds: second,
      milliseconds: millisecond,
      microseconds: microsecond,
    );
  }

  bool isSameDayWith(DateTime date) {
    return dateOnly().isAtSameMomentAs(date.dateOnly());
  }

  bool get isToday {
    final now = DateTime.now();
    return dateOnly().isSameDayWith(now.dateOnly());
  }

  /* API */
  String get apiDateTimeFormat =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  String get apiDateFormat => DateFormat('yyyy-MM-dd').format(this);
  String get apiTimeFormat => DateFormat('HH:mm:ss').format(this);
  String get apiYearMonthFormat => DateFormat('yyyy-MM').format(this);
}

extension XDuration on Duration {
  String durationTextFormat({
    bool isWithName = false,
    bool isWithSecond = false,
  }) {
    final padLeft = isWithName ? 0 : 2;
    final days = inDays.abs();
    final hours = inHours.remainder(24).abs();
    final minutes = inMinutes.remainder(60).abs();
    final seconds = inSeconds.remainder(60).abs();

    final String result;

    if (isWithName) {
      result =
          '${days != 0 ? '${days.toString().padLeft(padLeft, '0')} Days ' : ''}'
          '${hours != 0 ? '${hours.toString().padLeft(padLeft, '0')} Hour ' : ''}'
          '${minutes != 0 ? '${minutes.toString().padLeft(padLeft, '0')} Minute ' : ''}'
          '${seconds != 0 && isWithSecond ? '${seconds.toString().padLeft(padLeft, '0')} Second' : ''}';
    } else {
      result = '${days != 0 ? '${days.toString().padLeft(1, '0')}:' : ''}'
          '${hours != 0 ? '${hours.toString().padLeft(padLeft, '0')}:' : ''}'
          '${minutes != 0 ? '${minutes.toString().padLeft(padLeft, '0')}:' : ''}'
          '${seconds != 0 && isWithSecond ? seconds.toString().padLeft(padLeft, '0') : ''}';
    }

    return result;
  }
}
