import 'package:intl/intl.dart' as df;

formater({required value, format = "#,###"}) {
  var formatter = df.NumberFormat(format);
  String formattedNumber = formatter.format(value);
  return formattedNumber;
}
