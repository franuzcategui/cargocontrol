import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';


final shipsApisProvider = Provider<ShipsApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return ShipApis(firestore: firestoreProvider);
});


abstract class ShipsApisImplements {

  FutureEitherVoid finishVesselUnloading({required VesselModel vesselModel});
  Future<QuerySnapshot> getAllShips({int limit = 10, DocumentSnapshot? snapshot});
}

class ShipApis implements ShipsApisImplements{
  final FirebaseFirestore _firestore;
  ShipApis({required FirebaseFirestore firestore}): _firestore = firestore;



  @override
  FutureEitherVoid finishVesselUnloading({required VesselModel vesselModel}) async{
    try{
      await _firestore.collection(FirebaseConstants.vesselCollection).
      doc(vesselModel.vesselId).
      update(vesselModel.toMap());

      return const Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<QuerySnapshot> getAllShips({int limit = 10, DocumentSnapshot? snapshot}) async {
    Query query = _firestore.collection(FirebaseConstants.vesselCollection);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }



}