import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';


final inViajesApisProvider = Provider<InViajesApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return InViajesApis(firestore: firestoreProvider);
});


abstract class InViajesApisImplements {

  Future<QuerySnapshot> getAllViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId,required String industryId});
  Future<QuerySnapshot> getCompletedViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId,required String industryId});
  Future<QuerySnapshot> getInprogressViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId,required String industryId});

}

class InViajesApis implements InViajesApisImplements{
  final FirebaseFirestore _firestore;
  InViajesApis({required FirebaseFirestore firestore}): _firestore = firestore;





  @override
  Future<QuerySnapshot> getAllViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId,required String industryId}) async {
    Query query = _firestore.collection(FirebaseConstants.viajesCollection).where('vesselId',isEqualTo: vesselId).where('industryId',isEqualTo: industryId);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }

  @override
  Future<QuerySnapshot> getInprogressViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId,required String industryId}) async {
    Query query = _firestore.collection(FirebaseConstants.viajesCollection).where('viajesTypeEnum',isEqualTo: ViajesTypeEnum.inProgress.type).where('vesselId',isEqualTo: vesselId)..where('industryId',isEqualTo: industryId);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }
  @override
  Future<QuerySnapshot> getCompletedViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId,required String industryId}) async {
    Query query = _firestore.collection(FirebaseConstants.viajesCollection).where('viajesTypeEnum',isEqualTo: ViajesTypeEnum.completed.type).where('vesselId',isEqualTo: vesselId)..where('industryId',isEqualTo: industryId);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }


}