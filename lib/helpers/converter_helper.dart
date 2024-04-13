import 'package:intl/intl.dart';

class ConverterHelper{

  static String doubleParaReal(double valor) => NumberFormat.currency(locale: 'pt_BR', symbol: ' R\$').format(valor);

}