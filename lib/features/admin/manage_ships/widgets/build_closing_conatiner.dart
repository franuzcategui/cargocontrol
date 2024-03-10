import 'dart:typed_data';
import 'package:cargocontrol/features/admin/manage_ships/widgets/build_single_industry_info.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/build_vessel_info.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/pdf_text.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../utils/constants/font_manager.dart';

Widget buildClosingContainer(){
  return Container(
    width: 0.9.sw,
    padding: EdgeInsets.all(8.h),
    decoration: BoxDecoration(
      color: PdfColors.white,
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.r), bottomLeft: Radius.circular(15.r))
    ),
  );
}
