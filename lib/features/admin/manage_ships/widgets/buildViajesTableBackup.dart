import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;


import '../../../../models/viajes_models/viajes_model.dart';
import '../../../../utils/constants/app_constants.dart';

import 'package:pdf/widgets.dart' as pw;

Widget buildViajesTable(List<ViajesModel> viajesList) {
  final headers = [
    'Viaje ID',
    'No. de Guia',
    'Hora de salida',
    'Placa',
    'Nombre Chofer',
    'Producto',
    'Peso Tara',
    'Peso Bruto',
    'Peso Neto',
    'Total descargado',
    'Perdida (Kg)',
    'Perdida (%)',
    'Hora de llegada',
    'Hora de descarga',
    'Destino',
  ];

  // Function to conditionally set cell decoration
  BoxDecoration cellDecoration(int rowIndex, dynamic cellValue, int colIndex) {
    if (cellValue == '') {
      return pw.BoxDecoration(
        color: PdfColor.fromInt(0x00FFFFFF),
        border: pw.Border.all(
          width: 0,
        ),
      );
    }
    return pw.BoxDecoration();
  }

  const PdfColor rowColor1 = PdfColor.fromInt(0xFFEEEEEE);
  const PdfColor rowColor2 = PdfColor.fromInt(0xFFFFFFFF);

  return pw.Table.fromTextArray(
    headers: headers,
    data: [
      for (var viaje in viajesList) ...[
        [
          viaje.viajesId,
          viaje.guideNumber.toString(),
          formatDateTime(viaje.exitTimeToPort),
          viaje.licensePlate,
          viaje.chofereName,
          viaje.productName,
          viaje.entryTimeTruckWeightToPort.toString(),
          viaje.exitTimeTruckWeightToPort.toString(),
          (viaje.exitTimeTruckWeightToPort - viaje.entryTimeTruckWeightToPort).toString(),
          viaje.cargoUnloadWeight.toString(),
          viaje.cargoDeficitWeight.toString(),
          ((viaje.cargoDeficitWeight / viaje.pureCargoWeight) * 100).toStringAsFixed(2),
          formatDateTime(viaje.timeToIndustry),
          formatDateTime(viaje.unloadingTimeInIndustry),
          viaje.industryName,
        ]
      ],
    ],
    cellDecoration: cellDecoration,
    border: pw.TableBorder.all(width: 1, color: PdfColors.grey),
    headerStyle: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.white,
    ),
    headerCellDecoration: pw.BoxDecoration(color: PdfColor.fromInt(0xFF000000)),
    rowDecoration: const pw.BoxDecoration(color: rowColor1),
    oddRowDecoration: const pw.BoxDecoration(color: rowColor2),
    cellHeight: 30,
    cellAlignments: {
      for (var i = 0; i < headers.length; i++) i: pw.Alignment.center,
    },
  );
}

String formatDateTime(DateTime dateTime) {
  return "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
}









Widget buildInvoice(

    {required VesselModel vesselModel,
    required PdfColor color,
    EdgeInsetsGeometry? padding,
    PdfColor? headerTextCol}) {
  final headers = [
    'No',
    'Description',
    'Quantity',
    'Price',
    'discount',
    'Total'
  ];
  int i = 1;
  final data = vesselModel.cargoModels?.map((item) {
    final total = 225;
    return [
      i++,
      '${'dada'}\n${'asdasd'}',
      '${'adasd'}',
      '\$ ${'asdasd'}',
      '',
    //  '${item.discountRate}%',
      '\$asdasdasd)}'
          // '\$${((item.finalRate - item.discountRate) * item.soldQuantity!) + item.shippingCost!}', //\$ ${total.toStringAsFixed(2)}',
    ];
  }).toList();



  // Function to conditionally set cell decoration
  cellDecoration(int rowIndex, dynamic cellValue, int colIndex) {
    if (cellValue == '') {
      return BoxDecoration(
        color: const PdfColor.fromInt(0x00FFFFFF),
        border: Border.all(
          width: 0,
        ),
      );
    }
    return const BoxDecoration();
  }

  const PdfColor rowColor1 = PdfColor.fromInt(0xFFEEEEEE);
  const PdfColor rowColor2 = PdfColor.fromInt(0xFFFFFFFF);

  return Padding(
    padding: padding ??
        EdgeInsets.only(
            top: AppConstants.padding,
            left: AppConstants.padding,
            right: AppConstants.padding),
    child: Table.fromTextArray(
      headers: headers,
      data: data!,
      cellDecoration: cellDecoration,
      border: TableBorder.all(width: 1, color: PdfColors.grey),
      headerStyle: TextStyle(
          fontWeight: FontWeight.bold, color: headerTextCol ?? PdfColors.white),
      headerCellDecoration: BoxDecoration(color: color),
      rowDecoration: const BoxDecoration(color: rowColor1),
      oddRowDecoration: const BoxDecoration(color: rowColor2),
      // evenCellStyle: TextStyle(background: rowColor2),
      cellHeight: 30.h,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.centerLeft,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
        7: Alignment.center,
      },
    ),
  );
}


// Widget buildViajesTable(List<ViajesModel> viajesList) {
//   return pw.Table(
//     border: pw.TableBorder.all(),
//     columnWidths: {
//       0: pw.FixedColumnWidth(100),
//       1: pw.FixedColumnWidth(100),
//       // Adjust the column widths as needed
//     },
//     children: [
//       buildTableHeader(),
//       for (var viaje in viajesList) buildViajesInfoRow(viaje),
//     ],
//   );
// }
//
//









pw.TableRow buildTableHeader() {
  return pw.TableRow(
    children: [
      pw.Text("Viaje ID", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("No. de Guia", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Hora de salida", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Placa", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Nombre Chofer", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Producto", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Peso Tara", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Peso Bruto", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Peso Neto", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Total descargado", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Perdida (Kg)", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Perdida (%)", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Hora de llegada", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Hora de descarga", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("Destino", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    ],
  );
}

pw.TableRow buildViajesInfoRow(ViajesModel viaje) {
  return pw.TableRow(
    children: [
      pw.Text(viaje.viajesId),
      pw.Text(viaje.guideNumber.toString()),
      pw.Text(formatDateTime(viaje.exitTimeToPort)),
      pw.Text(viaje.licensePlate),
      pw.Text(viaje.chofereName),
      pw.Text(viaje.productName),
      pw.Text(viaje.entryTimeTruckWeightToPort.toString()),
      pw.Text(viaje.exitTimeTruckWeightToPort.toString()),
      pw.Text((viaje.exitTimeTruckWeightToPort - viaje.entryTimeTruckWeightToPort).toString()),
      pw.Text(viaje.cargoUnloadWeight.toString()),
      pw.Text(viaje.cargoDeficitWeight.toString()),
      pw.Text(((viaje.cargoDeficitWeight / viaje.pureCargoWeight) * 100).toStringAsFixed(2)),
      pw.Text(formatDateTime(viaje.timeToIndustry)),
      pw.Text(formatDateTime(viaje.unloadingTimeInIndustry)),
      pw.Text(viaje.industryName),
    ],
  );
}

// ...

// String formatDateTime(DateTime dateTime) {
//   return "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
// }