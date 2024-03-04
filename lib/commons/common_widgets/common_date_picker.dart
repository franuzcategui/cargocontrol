import 'dart:io';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/constants/font_manager.dart';
import '../common_imports/common_libs.dart';

Future<DateTime?> showPlatformDatePicker({
  required BuildContext context,
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? selctedDate,
}) async {
  DateTime selectedDate = DateTime.now();
  if (selctedDate != null) {
    selectedDate = selctedDate;
  }

  DateTime? pickedDate;
  pickedDate = await showModalBottomSheet<DateTime>(
    context: context,
    builder: (context) {
      DateTime tempPickedDate = selectedDate;
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 250.h,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                      child: Text('Cancel',
                          textAlign: TextAlign.center,
                          style: getMediumStyle(
                            color: MyColors.kMainColor,
                            fontSize: MyFonts.size16,
                          )),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  CupertinoButton(
                    child: Text('Done',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: MyColors.kMainColor,
                          fontSize: MyFonts.size16,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop(tempPickedDate);
                    },
                  ),
                ],
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: tempPickedDate,
                  minimumDate: firstDate ?? DateTime(1900),

                  maximumDate: lastDate ?? DateTime(2100),
                  mode: CupertinoDatePickerMode.dateAndTime,
                  // maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime dateTime) {
                    tempPickedDate = dateTime;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  return pickedDate;
}
