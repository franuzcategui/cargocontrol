import 'dart:io';
import 'package:csv/csv.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../commons/common_functions/date_time_methods.dart';
import '../../../../../models/viajes_models/viajes_model.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationSupportDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }
}


List<List<dynamic>> generateCsvData(List<ViajesModel> viajesList) {
  List<List<dynamic>> csvData = [];

  // Add CSV header
  csvData.add([
    'Viaje ID',
    'No. de Guia ',
    'Hora de salida',
    'Placa',
    'Nombre Chofer',
    'Producto',
    'Peso Tara ',
    'Peso Bruto',
    'Peso Neto',
    'Total descargado',
    'Perdida',
    'Perdida %',
    'Hora de llegada',
    'Hora de descarga',
    'Destino',
  ]);

  // Add data for each ViajesModel instance
  viajesList.forEach((viaje) {
    csvData.add([
      viaje.viajesId,
      viaje.guideNumber,
      formatDateTime(viaje.exitTimeToPort),
      viaje.licensePlate,
      viaje.chofereName,
      viaje.productName,
      viaje.entryTimeTruckWeightToPort,
      viaje.exitTimeTruckWeightToPort,
      (viaje.exitTimeTruckWeightToPort - viaje.entryTimeTruckWeightToPort),
      viaje.cargoUnloadWeight,
      viaje.cargoDeficitWeight,
      ((viaje.cargoDeficitWeight / viaje.pureCargoWeight) * 100),
      formatDateTime(viaje.timeToIndustry),
      formatDateTime(viaje.unloadingTimeInIndustry),
      viaje.industryName,
    ]);
  });

  return csvData;
}