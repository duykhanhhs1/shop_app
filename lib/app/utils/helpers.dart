import 'package:intl/intl.dart';

class NumberHelper {
static String currencyFormat(int value){
  return NumberFormat('#,###').format(value);
}
}