import 'package:intl/intl.dart';

dateFormat(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMMM yyyy');
  final String formatted = formatter.format(date);
  return formatted;
}

dateMonthYearFormat(DateTime date) {
  final DateFormat formatter = DateFormat('MMMM yyyy');
  final String formatted = formatter.format(date);
  return formatted;
}
