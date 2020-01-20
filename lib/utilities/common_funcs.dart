import 'package:intl/intl.dart';

String getTime(String char) {
  return '${DateFormat(char).format(DateTime.now())}';
}

String addZero(int second) {
  if (second >= 0 && second <= 9)
    return '0$second';
  else
    return '$second';
}
