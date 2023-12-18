import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cargocontrol/utils/thems/styles_manager.dart';

showSnackBar({
  required BuildContext context,
  required String content ,
  Color? backColor,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: backColor?? context.mainColor,
    duration: duration?? Duration(seconds: 2),
    content: Text(
      content,
      style: getRegularStyle(fontSize: 12.spMin, color: context.scaffoldBackgroundColor),
    ),
  ));
}

void showToast(
    {required String msg,
    Color? textColor,
    Color? backgroundColor,
    bool long = false}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? Colors.white,
    textColor: textColor ?? Colors.black,
    fontSize: 12.spMin,
  );
}
