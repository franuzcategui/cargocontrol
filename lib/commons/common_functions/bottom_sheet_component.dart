import 'package:cargocontrol/commons/common_imports/common_libs.dart';
import 'package:cargocontrol/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

void bottomSheetComponent(BuildContext context, Widget child, {double horizontalPadding = 20,
    bool isDismissible = true,
    bool adjustSizeOnOpenKeyboard = true}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    enableDrag: isDismissible,
    isDismissible: isDismissible,
    useRootNavigator: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => isDismissible,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: context.textFieldColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: adjustSizeOnOpenKeyboard
                    ? MediaQuery.of(context).viewInsets.bottom != 0
                        ? 400.h
                        : null
                    : null,
                child: child,
              ),
            ],
          ),
        ),
      );
    },
  );
}
