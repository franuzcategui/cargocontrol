import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';


final viajesApisProvider = Provider<ViajesApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return ViajesApis(firestore: firestoreProvider);
});


abstract class ViajesApisImplements {

  Future<QuerySnapshot> getAllViajes({int limit = 10, DocumentSnapshot? snapshot});
  Future<QuerySnapshot> getCompletedViajes({int limit = 10, DocumentSnapshot? snapshot});
  Future<QuerySnapshot> getInprogressViajes({int limit = 10, DocumentSnapshot? snapshot});

}

class ViajesApis implements ViajesApisImplements{
  final FirebaseFirestore _firestore;
  ViajesApis({required FirebaseFirestore firestore}): _firestore = firestore;





  @override
  Future<QuerySnapshot> getAllViajes({int limit = 10, DocumentSnapshot? snapshot}) async {
    Query query = _firestore.collection(FirebaseConstants.viajesCollection);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }

  @override
  Future<QuerySnapshot> getInprogressViajes({int limit = 10, DocumentSnapshot? snapshot}) async {
    Query query = _firestore.collection(FirebaseConstants.viajesCollection).where('viajesTypeEnum',isEqualTo: ViajesTypeEnum.inProgress.type);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }
  @override
  Future<QuerySnapshot> getCompletedViajes({int limit = 10, DocumentSnapshot? snapshot}) async {
    Query query = _firestore.collection(FirebaseConstants.viajesCollection).where('viajesTypeEnum',isEqualTo: ViajesTypeEnum.completed.type);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }


}