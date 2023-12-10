import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';


final adVesselApiProvider = Provider<AdVesselApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return AdVesselApis(firestore: firestoreProvider);
});


abstract class AdVesselApisImplements {

  FutureEitherVoid createVessel({required VesselModel vesselModel});
  Stream<List<VesselModel>> getVesselsList();
}

class AdVesselApis implements AdVesselApisImplements{
  final FirebaseFirestore _firestore;
  AdVesselApis({required FirebaseFirestore firestore}): _firestore = firestore;

  @override
  FutureEitherVoid createVessel({required VesselModel vesselModel}) async{
    try{
      await _firestore.collection(FirebaseConstants.vesselCollection).
      doc(vesselModel.vesselId).
      set(vesselModel.toMap());

      return const Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Stream<List<VesselModel>> getVesselsList() {
    return _firestore.collection(FirebaseConstants.vesselCollection).snapshots().map((event) {
      List<VesselModel> models = [];
      for (var document in event.docs) {
        var model = VesselModel.fromMap(document.data());
        models.add(model);
      }
      return models;
    });
  }
  
}