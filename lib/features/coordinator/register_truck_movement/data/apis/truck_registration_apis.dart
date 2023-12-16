import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';
import '../../../../../models/industry_models/industry_sub_model.dart';


final truckRegistrationApisProvider = Provider<TruckRegistrationApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return TruckRegistrationApis(firestore: firestoreProvider);
});


abstract class TruckRegistrationApisImplements {

  FutureEitherVoid registerTruckEnteringToPort({required ViajesModel viajesModel});
  FutureEitherVoid registerTruckLeavingFromPort({required ViajesModel viajesModel});
  Stream<QuerySnapshot<Map<String, dynamic>>> getLAllViajesModels();
  FutureEither<List<IndustrySubModel>> getAllIndustries();
}

class TruckRegistrationApis implements TruckRegistrationApisImplements{
  final FirebaseFirestore _firestore;
  TruckRegistrationApis({required FirebaseFirestore firestore}): _firestore = firestore;



  @override
  FutureEitherVoid registerTruckEnteringToPort({required ViajesModel viajesModel})async {
    try{
      await _firestore.collection(FirebaseConstants.viajesCollection).
      doc(viajesModel.viajesId).
      set(viajesModel.toMap());

      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  FutureEitherVoid registerTruckLeavingFromPort({required ViajesModel viajesModel}) async {
    try{
      await _firestore.collection(FirebaseConstants.viajesCollection).
      doc(viajesModel.viajesId).
      update(viajesModel.toMap());

      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getLAllViajesModels(){
    return _firestore.collection(FirebaseConstants.industryGuideCollection).
    snapshots();
  }

  @override
  FutureEither<List<IndustrySubModel>> getAllIndustries() async {
    try {
      var querySnapshot = await _firestore.collection(FirebaseConstants.industryGuideCollection).get();

      List<IndustrySubModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = IndustrySubModel.fromMap(document.data());
        models.add(model);
      }

      return Right(models);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

}