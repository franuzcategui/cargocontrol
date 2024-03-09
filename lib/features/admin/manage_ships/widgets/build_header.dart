import 'dart:typed_data';
import 'package:cargocontrol/features/admin/manage_ships/widgets/pdf_text.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../utils/constants/font_manager.dart';

Widget buildHeader(
        {required VesselModel vesselModel, Uint8List? companyLogo}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: pdfText(
                  text: 'Reporte general ',
                  color: PdfColors.black,
                  fontSize: MyFonts.size15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
                width: 200.w,
                child: FittedBox(
                    // width: 250.w,
                    alignment: AlignmentDirectional.centerStart,
                    fit: BoxFit.scaleDown,
                    child: Row(children: [
                      pdfText(
                          text: vesselModel.vesselName+" ",
                          color: MyColors.pdfMainColor,
                          fontSize: MyFonts.size15,
                          fontWeight: FontWeight.bold),
                     
                      pdfText(
                          text: formatDayMonthYear(vesselModel.entryDate),
                          color: MyColors.pdfMainColor,
                          fontSize: MyFonts.size15,
                          fontWeight: FontWeight.bold),
                    ]))),
            if (companyLogo != null) ...[
              SizedBox(width: 20.w),
              Image(MemoryImage(companyLogo), height: 27.h, width: 95.w),
            ],
          ],
        ),
      ],
    );
