import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
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
  FutureEitherVoid registerTruckEnteringInIndustry({required ViajesModel viajesModel, required IndustrySubModel industrySubModel,}) ;
  FutureEitherVoid registerTruckUnloadingInIndustry({
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getLAllViajesModels();
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortEnteringViajesList();
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortLeavingViajesList();
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustryEnteringViajesList();
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllViajesList();
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustriaIndustry({required String realIndustryId});

  FutureEither<List<IndustrySubModel>> getAllIndustries();
  FutureEither<ViajesModel> getMatchedViajes({required String plateNumber});
  FutureEither<ViajesModel> getMatchedViajesLinkedWithIndustry({
    required String plateNumber,
    required String industryId,
    required ViajesStatusEnum viajesStatusEnum,
  });
  FutureEither<IndustrySubModel> getIndustriaIndustrywithFuture({required String realIndustryId});
  FutureEither<VesselModel> getVesselCargoModel({required String vesselId});
  FutureEither<ChoferesModel> getChoferesForViajes({required String nationalId});
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
        transaction.update(
          _firestore.collection(FirebaseConstants.viajesCollection).
          doc(viajesModel.viajesId),
          viajesModel.toMap(),
        );
        transaction.update(
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
  FutureEitherVoid registerTruckEnteringInIndustry({required ViajesModel viajesModel, required IndustrySubModel industrySubModel,}) async {
    try{
      await _firestore.runTransaction((Transaction transaction) async {
        transaction.update(
          _firestore.collection(FirebaseConstants.viajesCollection).
          doc(viajesModel.viajesId),
          viajesModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.industryGuideCollection).
          doc(industrySubModel.industryId),
          industrySubModel.toMap(),
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
  FutureEitherVoid registerTruckUnloadingInIndustry({
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,

  }) async {
    try{
      await _firestore.runTransaction((Transaction transaction) async {
        transaction.update(
          _firestore.collection(FirebaseConstants.viajesCollection).
          doc(viajesModel.viajesId),
          viajesModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.industryGuideCollection).
          doc(industrySubModel.industryId),
          industrySubModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.choferesCollection).
          doc(choferesModel.choferNationalId),
          choferesModel.toMap(),
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
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustriaIndustry({required String realIndustryId}){
    return _firestore.collection(FirebaseConstants.industryGuideCollection).
    where('realIndustryId', isEqualTo: realIndustryId).
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

  @override
  FutureEither<ViajesModel> getMatchedViajesLinkedWithIndustry({
    required String plateNumber,
    required String industryId,
    required ViajesStatusEnum viajesStatusEnum,
  })async {
    try{
      print(viajesStatusEnum.type);
      print(plateNumber);
      print(industryId);
      final querySnapshot = await _firestore.collection(FirebaseConstants.viajesCollection).
      where('licensePlate', isEqualTo: plateNumber).
      where('industryId', isEqualTo: industryId).
      where('viajesStatusEnum', isEqualTo: viajesStatusEnum.type).
      get();
      if(querySnapshot.docs.length!=0){
        ViajesModel model = ViajesModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Truck Found!', StackTrace.fromString('getMatchedViajesLinkedWithIndustry')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<IndustrySubModel> getIndustriaIndustrywithFuture({required String realIndustryId})async{
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.industryGuideCollection).
      where('realIndustryId', isEqualTo: realIndustryId).
      get();
      if(querySnapshot.docs.length!=0){
        IndustrySubModel model = IndustrySubModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Industry Found!', StackTrace.fromString('getIndustriaIndustrywithFuture')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  FutureEither<VesselModel> getVesselCargoModel({required String vesselId}) async{
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.vesselCollection).
      where('vesselId', isEqualTo: vesselId).
      get();
      if(querySnapshot.docs.isNotEmpty){
        VesselModel model = VesselModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Vessel Found!', StackTrace.fromString('getVesselCargoModel')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<ChoferesModel> getChoferesForViajes({required String nationalId}) async{
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.choferesCollection).
      where('choferNationalId', isEqualTo: nationalId).
      get();
      if(querySnapshot.docs.isNotEmpty){
        ChoferesModel model = ChoferesModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Choferes Found!', StackTrace.fromString('getChoferesForViajes')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

}