import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  String dayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  String formattedDate = DateFormat("MMM yyyy, h:mm a").format(dateTime);

  return '${dayWithSuffix(dateTime.day)} $formattedDate';
}
