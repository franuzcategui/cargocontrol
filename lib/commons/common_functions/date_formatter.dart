import 'package:intl/intl.dart';

formatDate(DateTime? date){
  if(date == null){
    return 'dd/MM/yyyy';
  }else{
    return DateFormat('dd/MM/yyyy').format(date);
  }
}