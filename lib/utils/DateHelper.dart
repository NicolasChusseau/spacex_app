import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime? date) {
    if (date == null) {
      return 'Date inconnue';
    }
    return DateFormat.yMMMMd().add_Hm().format(date);
  }
}