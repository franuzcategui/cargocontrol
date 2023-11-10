import 'package:cargocontrol/features/choferes/controller/chofer_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class AddChoferFormFailure implements Exception {
  final String code;
  const AddChoferFormFailure(this.code);
}

class ChoferesRepository {
  Future<void> addChofer({
    required String id,
    required String nombrechofer,
  }) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('chofer/$id').get();
      if (snapshot.exists) {
        throw const AddChoferFormFailure('El registro del chofer ya existe');
      } else {
        await ref.push().set({
          'Id': id,
          'CamioneroID': nombrechofer,
          'Rating': 0.0,
          'Viajes': 0,
          'DeficitPromedio': 0.0,
        });
      }
    } on FirebaseException catch (e) {
      throw AddChoferFormFailure(e.message ?? e.code);
    }
  }
}
