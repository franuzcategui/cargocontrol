import 'dart:typed_data';
import 'package:cargocontrol/features/admin/manage_ships/widgets/pdf_text.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../utils/constants/font_manager.dart';

Widget buildVesselInfo(
        {required VesselModel vesselModel}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Container(
          width: 0.9.sw,
          padding: EdgeInsets.all(16.h),
          decoration: BoxDecoration(
            color: PdfColors.white,
            borderRadius: BorderRadius.circular(15.r),
            
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:
                    [
                      pdfText(
                          text: "Información de ",
                          color: PdfColors.black,
                          fontSize: MyFonts.size14,
                          fontWeight: FontWeight.bold),
                      pdfText(
                          text: "buque",
                          color: MyColors.pdfMainColor,
                          fontSize: MyFonts.size14,
                          fontWeight: FontWeight.bold),
                    ]
                ),
                SizedBox(height: 10.h,),
                buildPdfRow(
                    title: "Nombre de buque",
                    subText: vesselModel.vesselName
                ),
                if(vesselModel.isFinishedUnloading)
                  buildPdfRow(
                    title: "Puerto de salida",
                    subText: vesselModel.exitPort
                ),
                buildPdfRow(
                    title: "Puerto de llegada",
                    subText: vesselModel.entryPort
                ),
                buildPdfRow(
                    title: "Shipper",
                    subText: vesselModel.shipper
                ),
                buildPdfRow(
                    title: "Fecha de llegada",
                    subText: formatDayMonthYear(vesselModel.entryDate)
                ),
                if(vesselModel.isFinishedUnloading)
                buildPdfRow(
                    title: "Fecha de salida",
                    subText: formatDayMonthYear(vesselModel.exitDate)
                ),
                buildPdfRow(
                    title: "UN/Locode",
                    subText: vesselModel.unlcode
                ),
              ]),
        ),
      ],
    );
