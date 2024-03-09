import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../utils/constants/font_manager.dart';


pdfText({required text, required color, fontSize, fontWeight}) => Text(
    text,
    style: TextStyle(
        color: color,
        fontSize: fontSize.toDouble() ?? 15,
        fontWeight: fontWeight ?? FontWeight.normal));


buildPdfRow({required title, required subText,}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: 4.h,
      top:  4.h,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title, style: TextStyle(
        color: PdfColors.black,
        fontSize: MyFonts.size8,
        fontWeight:  FontWeight.normal)),),
        Container(
          constraints: BoxConstraints(
              maxWidth: 150.w,minWidth: 65.w
          ),
          child: Text(subText, style: TextStyle(
              color: PdfColors.black,
              fontSize: MyFonts.size8,
              fontWeight:  FontWeight.normal),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}

