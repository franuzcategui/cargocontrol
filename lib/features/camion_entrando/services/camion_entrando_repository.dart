import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class SubmitCamionEntrandoFormFailure implements Exception {
  final String code;
  const SubmitCamionEntrandoFormFailure(this.code);
}

class CamionEntrandoRepository {
  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<dynamic> getCurrentBuqueInfo() async {}

  Future<void> submitCamionEntrandoForm({
    required String numeroGuia,
    required String placa,
    required String nombrechofer,
    required double pesoTara,
  }) async {
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('viaje/$numeroGuia');
      await ref.set({
        'horaDeEntradaRomana': ServerValue.timestamp,
        'horaDeSalidaRomana': '',
        'horaDeLlegadaIndustria': '',
        'horaDeDescargaIndustria': '',
        'BuqueID': '',
        'IndustriaID': '',
        'ProductoID': '',
        'CoordinadorID': '',
        'numeroDeBodega': '',
        'numeroDeGuia': numeroGuia,
        'CamioneroID': nombrechofer,
        'Placa': placa,
        'PesoTara': pesoTara,
        'PesoBrutoSalida': 0.0,
        'PesoBrutoLlegada': 0.0,
        'Deficit': 0.0,
        'Estatus': 1,
      });
    } on FirebaseException catch (e) {
      throw SubmitCamionEntrandoFormFailure(e.message ?? e.code);
    }
  }
}
