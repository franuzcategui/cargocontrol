import 'dart:io';
import 'dart:typed_data';
import 'package:cargocontrol/features/admin/manage_ships/widgets/build_Industries_info.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/build_closing_conatiner.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/build_vessel_info.dart';
import 'package:cargocontrol/features/admin/manage_ships/widgets/pdf_text.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/widgets.dart';
import '../../../../../utils/constants/assets_manager.dart';
import '../../../../../utils/constants/font_manager.dart';
import 'package:pdf/pdf.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../models/industry_models/industry_sub_model.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../data/apis/pdf_api.dart';
import '../pdf_constants/pdf_constants.dart';
import 'buildViajesTable.dart';
import 'build_header.dart';
import 'build_single_industry_info.dart';

class ReportPDFFormat {
  static Future<File> generate(
      {required VesselModel vesselModel,
      required PdfColor color,
      required List<IndustrySubModel> allIndustriesModels,
      required List<ViajesModel> allViajesModel,
      String? imagePath}) async {
    final pdf = Document();

    Uint8List? imageData;

    if (imagePath != null) {
      final ByteData image = await rootBundle.load(imagePath ?? '');
      imageData = (image).buffer.asUint8List();
    }

    Uint8List? companyLogo;
    companyLogo = await PdfConstants.convertAssetToUnit8(AppAssets.logo);

    pdf.addPage(MultiPage(
      pageTheme: PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.w),
        buildBackground: (context) => FullPage(
          ignoreMargins: true,
          child: Container(color: color),
        ),
      ),
      build: (context) => [
        //buildHeader(vesselModel: vesselModel, companyLogo: companyLogo),
        buildVesselInfo(
          vesselModel: vesselModel,
        ),
        buildIndustriesInfo(
            vesselModel: vesselModel, allIndustriesModel: allIndustriesModels),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: allIndustriesModels.map<Widget>((industrySubModel) {
            return buildSingleIndustryInfo(
                industrySubModel: industrySubModel, vesselModel: vesselModel);
          }).toList(),
        ),
        buildClosingContainer(),
        SizedBox(height: .2.h * PdfPageFormat.cm),
        SizedBox(height: 1 * PdfPageFormat.cm),
        pdfText(text: "Viajies", color: MyColors.pdfMainColor,fontSize: MyFonts.size15,fontWeight: FontWeight.bold),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildViajesTable(allViajesModel),
      ],
      // footer: (context) => buildFooter(
      //   imageData: imageData,
      // ),
      header: (context) => buildHeader(vesselModel: vesselModel, companyLogo: companyLogo)
    ));

    return PdfApi.saveDocument(name:  "${vesselModel.vesselName}_${formatDD(vesselModel.entryDate)}.pdf", pdf: pdf);
  }

}
