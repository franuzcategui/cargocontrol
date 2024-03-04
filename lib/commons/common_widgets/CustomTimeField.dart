import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/utils/constants/font_manager.dart';
import 'package:cargocontrol/utils/thems/styles_manager.dart';

class CustomTimeField extends StatelessWidget {
  final TextEditingController controller;
  final DateTime dateTime;
  final String hintText;
  final String label;
  final bool showLabel;
  final Function() onTimeTap;

  const CustomTimeField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.showLabel = true,
    required this.dateTime, required this.onTimeTap,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Stack(
          children: [
            TextFormField(
              controller: controller,
              style: getMediumStyle(
                  fontSize: MyFonts.size12, color: context.textColor),
              decoration: InputDecoration(
                label: Text(
                  label,
                  style: getRegularStyle(
                      color: context.mainColor, fontSize: MyFonts.size14),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                errorStyle: getRegularStyle(
                    fontSize: MyFonts.size10,
                    color: Theme.of(context).colorScheme.error),
                hintText:hintText,
                hintStyle: getMediumStyle(
                    fontSize: MyFonts.size12, color: context.mainColor),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: context.mainColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: context.mainColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: context.mainColor)),
              ),
            ),
            GestureDetector(
              onTap: onTimeTap,
              child: Container(
                width: double.infinity,
                color: Colors.red.withOpacity(0.0),
                height: 52.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
