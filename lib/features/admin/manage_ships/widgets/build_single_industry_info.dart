import 'dart:typed_data';
import 'package:cargocontrol/features/admin/manage_ships/widgets/pdf_text.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../utils/constants/font_manager.dart';

Widget buildSingleIndustryInfo(
        {required IndustrySubModel industrySubModel,
        required VesselModel vesselModel}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 0.9.sw,
          padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 16.w),
          decoration: BoxDecoration(
            color: PdfColors.white,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Divider(thickness: 1.h, color: PdfColors.grey200),
                SizedBox(
                  height: 10.h,
                ),
                pdfText(
                  text: industrySubModel.industryName,
                  color: PdfColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MyFonts.size10,
                ),
                SizedBox(
                  height: 5.h,
                ),
                buildPdfRow(
                  title: "Cantidad total asignada",
                  subText: industrySubModel.cargoAssigned.toStringAsFixed(0),
                ),
                buildPdfRow(
                  title: "Cantitad total descargada",
                  subText: industrySubModel.cargoUnloaded.toStringAsFixed(0),
                ),
                buildPdfRow(
                    title: "Asignación",
                    subText: ((industrySubModel.cargoUnloaded /
                                    industrySubModel.cargoAssigned) *
                                100)
                            .toStringAsFixed(0) +
                        "%"),
                buildPdfRow(
                  title: "Perdida total (kg)",
                  subText: industrySubModel.deficit.toStringAsFixed(0),
                ),
                if (vesselModel.isFinishedUnloading)
                  buildPdfRow(
                      title: "Perdida total (%)",
                      subText: ((industrySubModel.deficit /
                                      industrySubModel.cargoAssigned) *
                                  100)
                              .toStringAsFixed(0) +
                          "%"),
                buildPdfRow(
                    title: "Viajes",
                    subText: industrySubModel.viajesIds.length.toString()),
                SizedBox(
                  height: 10.h,
                ),
              ]),
        ),
      ],
    );
