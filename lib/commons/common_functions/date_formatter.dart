import 'package:intl/intl.dart';

formatDate(DateTime? date){
  if(date == null){
    return 'dd/MM/yyyy';
  }else{
    return DateFormat('dd/MM/yyyy').format(date);
  }
}

String formatDateTimeForRecentRegisteries(DateTime? dateTime) {
  if (dateTime == null) {
    return ''; // or any default value you want for null DateTime
  }

  String formattedDate = '${dateTime.month}/${dateTime.day}/${dateTime.year % 100} ';
  formattedDate += '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';

  return formattedDate;
}