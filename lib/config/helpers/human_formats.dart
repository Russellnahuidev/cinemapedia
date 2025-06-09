import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, [int decimalDigits = 0]) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formatterNumber;
  }
}
