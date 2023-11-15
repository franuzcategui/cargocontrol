import 'package:cargocontrol/features/choferes/controller/chofer_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class AddChoferFormFailure implements Exception {
  final String code;
  const AddChoferFormFailure(this.code);
}

class ChoferesRepository {
  Future<(List<ChoferInfo>, DataSnapshot?)> fetchChoferes(
      {required int pageSize, DataSnapshot? lastDoc}) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      final initialQuery =
          ref.child('chofer').orderByKey().limitToFirst(pageSize);
      final query =
          lastDoc != null ? initialQuery.startAfter(lastDoc) : initialQuery;

      final snapshots = await query.get();
      if (snapshots.value == null) return (List<ChoferInfo>.empty(), null);
      final result =
          snapshots.children.map((e) => ChoferInfo.fromJson(e.value!)).toList();
      final users = result.whereType<ChoferInfo>().toList();
      return (users, snapshots.children.last);
    } on FirebaseException catch (e) {
      throw AddChoferFormFailure(e.message ?? e.code);
    }
  }

  Stream<(List<ChoferInfo>, DataSnapshot?)> listenToChoferesList(
      {required int pageSize, DataSnapshot? lastDoc}) {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final initialQuery =
        ref.child('chofer').orderByKey().limitToFirst(pageSize);
    final query =
        lastDoc != null ? initialQuery.startAfter(lastDoc) : initialQuery;
    return query.onValue.map((event) {
      final snapshots = event.snapshot;
      if (snapshots.value == null) return (List<ChoferInfo>.empty(), null);
      final result =
          snapshots.children.map((e) => ChoferInfo.fromJson(e.value!)).toList();
      final users = result.whereType<ChoferInfo>().toList();
      return (users, snapshots.children.last);
    });
  }

  Future<void> addChofer({
    required String id,
    required String nombrechofer,
  }) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref('chofer');
      final snapshot = await ref.child('$id').get();
      if (snapshot.exists) {
        throw const AddChoferFormFailure('El registro del chofer ya existe');
      } else {
        await ref.child('$id').update({
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

    Future<void> removeChofer(String id) async {
      try {
        DatabaseReference ref = FirebaseDatabase.instance.ref('chofer');
        final snapshot = await ref.child('$id').get();
        if (snapshot.exists) {
          await ref.child('$id').remove();
        } else {
          throw const AddChoferFormFailure(
              'El registro del chofer no existe en la base de datos');
        }
      } on FirebaseException catch (e) {
        throw AddChoferFormFailure(e.message ?? e.code);
      }
    }
  }
}
