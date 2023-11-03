import 'package:intl/intl.dart';

class TimeUtils {
  static String relativeTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    String formatted;
    Duration difference = now.difference(dateTime);

    if (difference.inDays >= 1) {
      formatted = DateFormat('yyyy.MM.dd').format(dateTime);
    } else if (difference.inHours >= 1) {
      formatted = '${difference.inHours}시간 전';
    } else if (difference.inMinutes >= 1) {
      formatted = '${difference.inMinutes}분 전';
    } else {
      formatted = '방금 전';
    }

    return formatted;
  }
}
