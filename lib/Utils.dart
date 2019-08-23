import 'package:intl/intl.dart';

String dateTime_yMedjm(DateTime dateTime){
  return DateFormat("yMEd").add_jm().format(dateTime);
}
