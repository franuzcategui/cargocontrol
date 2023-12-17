import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
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

  FutureEitherVoid registerTruckEnteringToPort({required ViajesModel viajesModel, required IndustrySubModel industrySubModel,});
  FutureEitherVoid registerTruckLeavingFromPort({required ViajesModel viajesModel, required VesselModel vesselModel,});
  Stream<QuerySnapshot<Map<String, dynamic>>> getLAllViajesModels();
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortEnteringViajesList();
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortLeavingViajesList();
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustryEnteringViajesList();
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllViajesList();
  FutureEither<List<IndustrySubModel>> getAllIndustries();
  FutureEither<ViajesModel> getMatchedViajes({required String plateNumber});
}

class TruckRegistrationApis implements TruckRegistrationApisImplements{
  final FirebaseFirestore _firestore;
  TruckRegistrationApis({required FirebaseFirestore firestore}): _firestore = firestore;



  @override
  FutureEitherVoid registerTruckEnteringToPort({
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
  })async {
    try{
      await _firestore.runTransaction((Transaction transaction) async {
        transaction.set(
          _firestore.collection(FirebaseConstants.viajesCollection).
          doc(viajesModel.viajesId),
          viajesModel.toMap(),
        );
        transaction.set(
          _firestore.collection(FirebaseConstants.industryGuideCollection).
          doc(industrySubModel.industryId),
          industrySubModel.toMap(),
        );
      });
      return const Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  FutureEitherVoid registerTruckLeavingFromPort({required ViajesModel viajesModel, required VesselModel vesselModel,}) async {
    try{
      await _firestore.runTransaction((Transaction transaction) async {
        transaction.set(
          _firestore.collection(FirebaseConstants.viajesCollection).
          doc(viajesModel.viajesId),
          viajesModel.toMap(),
        );
        transaction.set(
          _firestore.collection(FirebaseConstants.vesselCollection).
          doc(vesselModel.vesselId),
          vesselModel.toMap(),
        );
      });
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
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortEnteringViajesList(){
    return _firestore.collection(FirebaseConstants.viajesCollection).
    where('viajesStatusEnum', isEqualTo: ViajesStatusEnum.portEntered.type).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortLeavingViajesList(){
    return _firestore.collection(FirebaseConstants.viajesCollection).
    where('viajesStatusEnum', isEqualTo: ViajesStatusEnum.portLeft.type).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustryEnteringViajesList(){
    return _firestore.collection(FirebaseConstants.viajesCollection).
    where('viajesStatusEnum', isEqualTo: ViajesStatusEnum.industryEntered.type).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllViajesList(){
    return _firestore.collection(FirebaseConstants.viajesCollection).
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


  @override
  FutureEither<ViajesModel> getMatchedViajes({required String plateNumber})async {
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.viajesCollection).
      where('licensePlate', isEqualTo: plateNumber).
      get();
      if(querySnapshot.docs.length!=0){
        ViajesModel model = ViajesModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Truck Found!', StackTrace.fromString('getMatchedViajes')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

}